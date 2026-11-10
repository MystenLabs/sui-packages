module 0x3b09716175e449616e314819711f01cb2231e33393ec0fb43b93be4891d63c42::main {
    struct RedeemTicket {
        vault_id: 0x2::object::ID,
        payment: 0x2::coin::Coin<0x3b09716175e449616e314819711f01cb2231e33393ec0fb43b93be4891d63c42::bkusd::BKUSD>,
        amount: u64,
        supply: u64,
        index: u64,
        paid_any: bool,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        vault_coin: 0x2::bag::Bag,
        lay_in_coin: 0x2::bag::Bag,
        decimals_data: 0x2::table::Table<0x1::type_name::TypeName, u8>,
        types: vector<0x1::type_name::TypeName>,
        version_delay: u64,
        add_delay: u64,
        version: u64,
        redeeming: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TemporaryCap has store, key {
        id: 0x2::object::UID,
    }

    struct Flash_loan_receipt<phantom T0> {
        amount: u64,
    }

    struct Add_coin_type has copy, drop {
        coin_type: 0x1::type_name::TypeName,
    }

    struct Update_Contract has copy, drop {
        time: u64,
        version: u64,
    }

    struct Minting_tokens has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        bkusd: u64,
    }

    struct Redemption_tokens has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct Brun_bkusd has copy, drop {
        amount: u64,
    }

    struct Flash_loan_e has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        fee: u64,
    }

    public fun Disable_automatic_version_downgrading(arg0: &AdminCap, arg1: &mut Vault, arg2: &0x2::clock::Clock) {
        assert!(arg1.version_delay != 0, 0);
        if (arg1.version == 1) {
            arg1.version_delay = 0;
        };
    }

    fun add_coin_type<T0>(arg0: 0x1::type_name::TypeName, arg1: u8, arg2: &mut Vault) {
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg2.vault_coin, arg0, 0x2::balance::zero<T0>());
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg2.lay_in_coin, arg0, 0x2::balance::zero<T0>());
        0x2::table::add<0x1::type_name::TypeName, u8>(&mut arg2.decimals_data, arg0, arg1);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg2.types, arg0);
    }

    public fun cancel_add_type<T0>(arg0: &mut AdminCap, arg1: &mut Vault, arg2: &0x2::clock::Clock) {
        arg1.add_delay = 0;
        0x2::dynamic_field::remove<0x1::type_name::TypeName, u8>(&mut arg0.id, 0x1::type_name::with_defining_ids<T0>());
    }

    public fun change_add_coin_type<T0>(arg0: &mut AdminCap, arg1: &mut Vault, arg2: &0x2::clock::Clock) {
        assert!(arg1.add_delay < 0x2::clock::timestamp_ms(arg2), 0);
        arg1.add_delay = 0;
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        add_coin_type<T0>(v0, 0x2::dynamic_field::remove<0x1::type_name::TypeName, u8>(&mut arg0.id, v0), arg1);
    }

    public fun change_add_delay<T0>(arg0: &mut AdminCap, arg1: &mut Vault, arg2: u8, arg3: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x2::bag::contains<0x1::type_name::TypeName>(&arg1.vault_coin, v0), 1);
        assert!(arg1.add_delay == 0, 0);
        arg1.add_delay = 0x2::clock::timestamp_ms(arg3) + 259200000;
        0x2::dynamic_field::add<0x1::type_name::TypeName, u8>(&mut arg0.id, v0, arg2);
        let v1 = Add_coin_type{coin_type: v0};
        0x2::event::emit<Add_coin_type>(v1);
    }

    public fun change_add_version_delay(arg0: &AdminCap, arg1: &mut Vault, arg2: &0x2::clock::Clock) {
        arg1.version_delay = 0x2::clock::timestamp_ms(arg2) + 518400000;
        arg1.version = arg1.version + 1;
        let v0 = Update_Contract{
            time    : arg1.version_delay,
            version : arg1.version,
        };
        0x2::event::emit<Update_Contract>(v0);
    }

    public fun dele_TemporaryCap(arg0: TemporaryCap) {
        let TemporaryCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun finish_retrieve(arg0: &mut Vault, arg1: &mut 0x3b09716175e449616e314819711f01cb2231e33393ec0fb43b93be4891d63c42::bkusd::Minter, arg2: RedeemTicket) {
        assert!(arg0.redeeming, 5);
        assert!(arg2.vault_id == 0x2::object::id<Vault>(arg0), 9);
        assert!(arg2.index == 0x1::vector::length<0x1::type_name::TypeName>(&arg0.types), 7);
        assert!(arg2.paid_any, 8);
        let RedeemTicket {
            vault_id : _,
            payment  : v1,
            amount   : _,
            supply   : v3,
            index    : _,
            paid_any : _,
        } = arg2;
        let v6 = v1;
        assert!(0x3b09716175e449616e314819711f01cb2231e33393ec0fb43b93be4891d63c42::bkusd::get_total_supply(arg1) == v3, 8);
        let v7 = Brun_bkusd{amount: 0x2::coin::value<0x3b09716175e449616e314819711f01cb2231e33393ec0fb43b93be4891d63c42::bkusd::BKUSD>(&v6)};
        0x2::event::emit<Brun_bkusd>(v7);
        0x3b09716175e449616e314819711f01cb2231e33393ec0fb43b93be4891d63c42::bkusd::burn(arg1, v6);
        arg0.redeeming = false;
    }

    public fun flash_loan_borrow<T0>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Flash_loan_receipt<T0>) {
        assert!(!arg0.redeeming, 5);
        assert!(arg0.version == 1, 2);
        assert!(arg1 >= 100000, 4);
        let v0 = Flash_loan_receipt<T0>{amount: arg1};
        (0x2::coin::take<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault_coin, 0x1::type_name::with_defining_ids<T0>()), arg1, arg2), v0)
    }

    public fun flash_loan_repay<T0>(arg0: &mut Vault, arg1: Flash_loan_receipt<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.version == 1, 2);
        assert!(!arg0.redeeming, 5);
        let Flash_loan_receipt { amount: v0 } = arg1;
        let v1 = v0 / 10000 * (2 as u64);
        assert!(0x2::coin::value<T0>(&arg2) >= v0 + v1, 3);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        0x2::coin::put<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault_coin, v2), 0x2::coin::split<T0>(&mut arg2, v0, arg3));
        0x2::coin::put<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.lay_in_coin, v2), 0x2::coin::split<T0>(&mut arg2, v1, arg3));
        let v3 = Flash_loan_e{
            coin_type : v2,
            amount    : v0,
            fee       : v1,
        };
        0x2::event::emit<Flash_loan_e>(v3);
        arg2
    }

    public fun get_fee<T0>(arg0: &AdminCap, arg1: u64, arg2: &mut Vault) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg2.lay_in_coin, 0x1::type_name::with_defining_ids<T0>()), arg1)
    }

    public fun get_fee_balance<T0>(arg0: &Vault) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.lay_in_coin, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.lay_in_coin, v0))
        } else {
            0
        }
    }

    public fun get_vault_balance<T0>(arg0: &Vault) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.vault_coin, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.vault_coin, v0))
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id            : 0x2::object::new(arg0),
            vault_coin    : 0x2::bag::new(arg0),
            lay_in_coin   : 0x2::bag::new(arg0),
            decimals_data : 0x2::table::new<0x1::type_name::TypeName, u8>(arg0),
            types         : 0x1::vector::empty<0x1::type_name::TypeName>(),
            version_delay : 0,
            add_delay     : 0,
            version       : 1,
            redeeming     : false,
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = TemporaryCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<TemporaryCap>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Vault>(v0);
    }

    public fun init_add_type<T0>(arg0: &TemporaryCap, arg1: u8, arg2: &mut Vault) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        add_coin_type<T0>(v0, arg1, arg2);
        let v1 = Add_coin_type{coin_type: v0};
        0x2::event::emit<Add_coin_type>(v1);
    }

    public fun mint_bkusd<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x3b09716175e449616e314819711f01cb2231e33393ec0fb43b93be4891d63c42::bkusd::Minter, arg2: &mut Vault, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.version == 1, 2);
        assert!(!arg2.redeeming, 5);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg2.vault_coin, v0), 1);
        let v1 = *0x2::table::borrow<0x1::type_name::TypeName, u8>(&arg2.decimals_data, v0);
        let v2 = 0x2::coin::value<T0>(&arg0);
        let v3 = if (v1 == 6) {
            v2
        } else if (v1 > 6) {
            let v4 = v1 - 6;
            assert!(v4 <= 19, 1001);
            v2 / 0x1::u64::pow(10, v4)
        } else {
            v2 * 0x1::u64::pow(10, 6 - v1)
        };
        assert!(v3 > 0, 1002);
        0x2::coin::put<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg2.vault_coin, v0), arg0);
        0x3b09716175e449616e314819711f01cb2231e33393ec0fb43b93be4891d63c42::bkusd::mint(arg1, v3, arg3);
        let v5 = Minting_tokens{
            coin_type : v0,
            amount    : v2,
            bkusd     : v3,
        };
        0x2::event::emit<Minting_tokens>(v5);
    }

    public fun public_automatic_version_downgrading(arg0: &mut Vault, arg1: &0x2::clock::Clock) {
        assert!(arg0.version_delay < 0x2::clock::timestamp_ms(arg1), 1);
        assert!(arg0.version_delay != 0, 0);
        arg0.version = arg0.version - 1;
        arg0.version_delay = 0;
    }

    public fun retrieve_one<T0>(arg0: &mut Vault, arg1: RedeemTicket, arg2: &mut 0x2::tx_context::TxContext) : RedeemTicket {
        assert!(arg0.redeeming, 5);
        assert!(arg1.vault_id == 0x2::object::id<Vault>(arg0), 9);
        assert!(arg1.index < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.types), 6);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.types, arg1.index);
        assert!(v0 == v1, 6);
        let v2 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault_coin, v0);
        let v3 = (((0x2::balance::value<T0>(v2) as u256) * (arg1.amount as u256) / (arg1.supply as u256)) as u64);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(v2, v3, arg2), 0x2::tx_context::sender(arg2));
            arg1.paid_any = true;
        };
        arg1.index = arg1.index + 1;
        let v4 = Redemption_tokens{
            coin_type : v1,
            amount    : v3,
        };
        0x2::event::emit<Redemption_tokens>(v4);
        arg1
    }

    public fun retrieve_usd(arg0: 0x2::coin::Coin<0x3b09716175e449616e314819711f01cb2231e33393ec0fb43b93be4891d63c42::bkusd::BKUSD>, arg1: &0x3b09716175e449616e314819711f01cb2231e33393ec0fb43b93be4891d63c42::bkusd::Minter, arg2: &mut Vault) : RedeemTicket {
        assert!(!arg2.redeeming, 5);
        assert!(arg2.version == 1, 2);
        let v0 = 0x2::coin::value<0x3b09716175e449616e314819711f01cb2231e33393ec0fb43b93be4891d63c42::bkusd::BKUSD>(&arg0);
        let v1 = 0x3b09716175e449616e314819711f01cb2231e33393ec0fb43b93be4891d63c42::bkusd::get_total_supply(arg1);
        assert!(v0 > 0 && v0 <= v1, 8);
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg2.types) == 0x2::bag::length(&arg2.vault_coin), 6);
        arg2.redeeming = true;
        RedeemTicket{
            vault_id : 0x2::object::id<Vault>(arg2),
            payment  : arg0,
            amount   : v0,
            supply   : v1,
            index    : 0,
            paid_any : false,
        }
    }

    // decompiled from Move bytecode v7
}

