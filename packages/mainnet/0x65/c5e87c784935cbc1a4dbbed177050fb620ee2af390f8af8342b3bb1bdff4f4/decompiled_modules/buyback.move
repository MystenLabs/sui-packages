module 0x65c5e87c784935cbc1a4dbbed177050fb620ee2af390f8af8342b3bb1bdff4f4::buyback {
    struct Unit has copy, drop, store {
        dummy_field: bool,
    }

    struct BuybackAdminCap has key {
        id: 0x2::object::UID,
        buyback: 0x2::object::ID,
    }

    struct Buyback<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        merkle_root: vector<u8>,
        completed_addresses: 0x2::table::Table<address, Unit>,
        token_price_mist: u64,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        input_exponent: u8,
        burned_tokens: 0x2::balance::Balance<T0>,
    }

    fun burn_tokens<T0: drop>(arg0: &mut Buyback<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.burned_tokens, arg1);
    }

    fun compute_mist_amount<T0: drop>(arg0: &Buyback<T0>, arg1: u64) : u64 {
        arg1 * arg0.token_price_mist / 0x1::u64::pow(10, arg0.input_exponent)
    }

    public fun deposit_sui<T0: drop>(arg0: &mut Buyback<T0>, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, arg1);
    }

    public fun exchange_balance_for_sui<T0: drop>(arg0: &mut Buyback<T0>, arg1: vector<vector<u8>>, arg2: 0x2::balance::Balance<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x2::balance::value<T0>(&arg2);
        let v1 = compute_mist_amount<T0>(arg0, v0);
        assert!(validate_buyback_from_merkle_root<T0>(arg0, arg1, 0x2::tx_context::sender(arg3), v0), 1);
        assert!(!has_already_bought_back<T0>(arg0, 0x2::tx_context::sender(arg3)), 2);
        assert!(has_sufficient_sui<T0>(arg0, v1), 3);
        burn_tokens<T0>(arg0, arg2);
        mark_buyback_as_completed<T0>(arg0, 0x2::tx_context::sender(arg3));
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, v1)
    }

    public fun execute_atomic_buyback<T0: drop>(arg0: &mut Buyback<T0>, arg1: vector<vector<u8>>, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg2, arg3, arg4));
        let v1 = exchange_balance_for_sui<T0>(arg0, arg1, v0, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg4), 0x2::tx_context::sender(arg4));
    }

    public fun execute_atomic_deposit_sui<T0: drop>(arg0: &mut Buyback<T0>, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        deposit_sui<T0>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg1, arg2, arg3)));
    }

    public fun has_already_bought_back<T0: drop>(arg0: &Buyback<T0>, arg1: address) : bool {
        0x2::table::contains<address, Unit>(&arg0.completed_addresses, arg1)
    }

    fun has_sufficient_sui<T0: drop>(arg0: &Buyback<T0>, arg1: u64) : bool {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) >= arg1
    }

    public fun initialize<T0: drop>(arg0: vector<u8>, arg1: u64, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : BuybackAdminCap {
        let v0 = Buyback<T0>{
            id                  : 0x2::object::new(arg3),
            merkle_root         : arg0,
            completed_addresses : 0x2::table::new<address, Unit>(arg3),
            token_price_mist    : arg1,
            sui_balance         : arg2,
            input_exponent      : 5,
            burned_tokens       : 0x2::balance::zero<T0>(),
        };
        let v1 = BuybackAdminCap{
            id      : 0x2::object::new(arg3),
            buyback : 0x2::object::uid_to_inner(&v0.id),
        };
        0x2::transfer::public_share_object<Buyback<T0>>(v0);
        v1
    }

    public fun initialize_buyback_atomic<T0: drop>(arg0: vector<u8>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = initialize<T0>(arg0, arg2, 0x2::coin::into_balance<0x2::sui::SUI>(arg1), arg3);
        0x2::transfer::transfer<BuybackAdminCap>(v0, 0x2::tx_context::sender(arg3));
    }

    fun mark_buyback_as_completed<T0: drop>(arg0: &mut Buyback<T0>, arg1: address) {
        let v0 = Unit{dummy_field: false};
        0x2::table::add<address, Unit>(&mut arg0.completed_addresses, arg1, v0);
    }

    fun serialize_buyback_leaf(arg0: &address, arg1: u64) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<address>(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        v0
    }

    fun validate_buyback_from_merkle_root<T0: drop>(arg0: &Buyback<T0>, arg1: vector<vector<u8>>, arg2: address, arg3: u64) : bool {
        0x65c5e87c784935cbc1a4dbbed177050fb620ee2af390f8af8342b3bb1bdff4f4::merkle_proof::verify(&arg1, arg0.merkle_root, 0x1::hash::sha3_256(serialize_buyback_leaf(&arg2, arg3)))
    }

    public fun withdraw_sui<T0: drop>(arg0: &mut Buyback<T0>, arg1: &BuybackAdminCap, arg2: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.buyback, 4);
        assert!(has_sufficient_sui<T0>(arg0, arg2), 3);
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, arg2)
    }

    // decompiled from Move bytecode v6
}

