module 0x1441a62b7f47aee4dfdbca71e9b41cc97a3eca5ed6cbeca52a42ed9770a9b3a5::multisender {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Receipt {
        fee: u64,
        batches: u64,
        batches_sent: u64,
        total: u64,
        coin_type: 0x1::ascii::String,
    }

    struct Multisender has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        base_fee: u64,
        paused: bool,
    }

    struct Multisended has copy, drop {
        total: u64,
        fee: u64,
        batches: u64,
        coin_type: 0x1::ascii::String,
    }

    public fun batch_transfer<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: vector<u64>, arg2: vector<address>, arg3: &mut Receipt, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = validate_input<T0>(arg0, arg2, arg1);
        perform_transfers<T0>(arg0, arg1, arg2, arg4);
        arg3.batches_sent = arg3.batches_sent + 1;
        arg3.total = arg3.total + v0;
    }

    fun calculate_fee(arg0: u64, arg1: u64, arg2: &Multisender) : u64 {
        arg0 * arg1 + arg2.base_fee
    }

    fun calculate_total_amount(arg0: vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0)) {
            v0 = v0 + *0x1::vector::borrow<u64>(&arg0, v1);
            v1 = v1 + 1;
        };
        v0
    }

    public fun collect_profits(arg0: &AdminCap, arg1: &mut Multisender, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.balance) > 0, 0);
        0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.balance), arg2)
    }

    public fun get_receipt<T0>(arg0: u64, arg1: u64, arg2: &Multisender) : Receipt {
        assert!(arg1 <= 4, 3);
        assert!(!arg2.paused, 4);
        Receipt{
            fee          : arg0,
            batches      : arg1,
            batches_sent : 0,
            total        : 0,
            coin_type    : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Multisender{
            id       : 0x2::object::new(arg0),
            balance  : 0x2::balance::zero<0x2::sui::SUI>(),
            base_fee : 100000,
            paused   : false,
        };
        0x2::transfer::share_object<Multisender>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun pause(arg0: &AdminCap, arg1: &mut Multisender) {
        arg1.paused = true;
    }

    fun perform_transfers<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: vector<u64>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg1)) {
            0x2::pay::split_and_transfer<T0>(arg0, *0x1::vector::borrow<u64>(&arg1, v0), *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
        };
    }

    public fun renounce_admin(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public fun spent_receipt(arg0: Receipt, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut Multisender, arg3: &mut 0x2::tx_context::TxContext) {
        let Receipt {
            fee          : v0,
            batches      : v1,
            batches_sent : v2,
            total        : v3,
            coin_type    : v4,
        } = arg0;
        let v5 = calculate_fee(v0, v1, arg2);
        assert!(v5 > 0, 1);
        assert!(v2 == v1, 1);
        assert!(v5 <= 0x2::coin::value<0x2::sui::SUI>(arg1), 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.balance, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), v5));
        let v6 = Multisended{
            total     : v3,
            fee       : v5,
            batches   : v1,
            coin_type : v4,
        };
        0x2::event::emit<Multisended>(v6);
    }

    public fun unpause(arg0: &AdminCap, arg1: &mut Multisender) {
        arg1.paused = false;
    }

    public fun update_base_fee(arg0: &AdminCap, arg1: &mut Multisender, arg2: u64) {
        assert!(arg2 > 0, 1);
        assert!(arg2 < 1000000, 5);
        arg1.base_fee = arg2;
    }

    fun validate_input<T0>(arg0: &0x2::coin::Coin<T0>, arg1: vector<address>, arg2: vector<u64>) : u64 {
        assert!(0x1::vector::length<address>(&arg1) <= 510, 2);
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2), 1);
        let v0 = calculate_total_amount(arg2);
        assert!(0x2::coin::value<T0>(arg0) >= v0, 0);
        v0
    }

    // decompiled from Move bytecode v6
}

