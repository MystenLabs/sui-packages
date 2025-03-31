module 0x6304e189abb2693eee9819c0dfe8e983bba39815f1bf6396ec22ccbc036183d4::suia_v2 {
    struct Global has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        fee_recipient: address,
        withdraw_authority: address,
        initial_virtual_token_reserves: u64,
        initial_virtual_sui_reserves: u64,
        initial_real_token_reserves: u64,
        token_total_supply: u64,
        fee_basis_points: u64,
        bonding_curves: 0x2::table::Table<u64, address>,
    }

    struct BondingCurve<phantom T0> has store, key {
        id: 0x2::object::UID,
        creator: address,
        xid: u64,
        reserved_token: 0x2::balance::Balance<T0>,
        virtual_token_reserves: u64,
        virtual_sui_reserves: u64,
        real_token_reserves: 0x2::balance::Balance<T0>,
        real_sui_reserves: 0x2::balance::Balance<0x2::sui::SUI>,
        token_total_supply: u64,
        complete: bool,
    }

    struct CreateEvent has copy, drop {
        creator: address,
        bonding_curve: address,
        token: 0x1::ascii::String,
        xid: u64,
    }

    struct BuyEvent has copy, drop {
        buyer: address,
        bonding_curve: address,
        token: 0x1::ascii::String,
        token_amount: u64,
        sui_amount: u64,
    }

    struct SellEvent has copy, drop {
        seller: address,
        bonding_curve: address,
        token: 0x1::ascii::String,
        token_amount: u64,
        sui_amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        withdrawer: address,
        bonding_curve: address,
        token: 0x1::ascii::String,
        sui_amount: u64,
        token_amount: u64,
    }

    struct CompleteEvent has copy, drop {
        bonding_curve: address,
        token: 0x1::ascii::String,
    }

    fun assert_admin(arg0: &Global, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
    }

    fun assert_version(arg0: &Global) {
        assert!(arg0.version == 0, 2);
    }

    public fun buy<T0>(arg0: &mut Global, arg1: &mut BondingCurve<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        assert_version(arg0);
        assert!(!arg1.complete, 7);
        assert!(arg3 > 0, 8);
        assert!(arg3 <= 0x2::balance::value<T0>(&arg1.real_token_reserves), 4);
        let (v0, v1, v2) = get_buy_amount_by_token<T0>(arg1, arg3);
        assert!(v0 <= arg4, 5);
        let v3 = (((v0 as u128) * (arg0.fee_basis_points as u128) / 10000) as u64);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v0 + v3, 6);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.real_sui_reserves, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v0, arg5)));
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v3, arg5), arg0.fee_recipient);
        };
        arg1.virtual_token_reserves = v1;
        arg1.virtual_sui_reserves = v2;
        let v4 = 0x2::object::uid_to_address(&arg1.id);
        let v5 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (0x2::balance::value<T0>(&arg1.real_token_reserves) == 0) {
            arg1.complete = true;
            let v6 = CompleteEvent{
                bonding_curve : v4,
                token         : v5,
            };
            0x2::event::emit<CompleteEvent>(v6);
        };
        let v7 = BuyEvent{
            buyer         : 0x2::tx_context::sender(arg5),
            bonding_curve : v4,
            token         : v5,
            token_amount  : arg3,
            sui_amount    : v0,
        };
        0x2::event::emit<BuyEvent>(v7);
        (arg2, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.real_token_reserves, arg3), arg5))
    }

    public entry fun buy_entry<T0>(arg0: &mut Global, arg1: &mut BondingCurve<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = buy<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v2 = 0x2::tx_context::sender(arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, v2);
    }

    public entry fun create<T0>(arg0: &mut Global, arg1: u64, arg2: 0x2::coin::TreasuryCap<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<BondingCurve<T0>>(create_internal<T0>(arg0, arg1, arg2, arg3));
    }

    public entry fun create_and_buy<T0>(arg0: &mut Global, arg1: u64, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = create_internal<T0>(arg0, arg1, arg2, arg6);
        let v1 = &mut v0;
        let (v2, v3) = buy<T0>(arg0, v1, arg3, arg4, arg5, arg6);
        0x2::transfer::public_share_object<BondingCurve<T0>>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, 0x2::tx_context::sender(arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg6));
    }

    fun create_internal<T0>(arg0: &mut Global, arg1: u64, arg2: 0x2::coin::TreasuryCap<T0>, arg3: &mut 0x2::tx_context::TxContext) : BondingCurve<T0> {
        assert_version(arg0);
        assert!(!0x2::table::contains<u64, address>(&arg0.bonding_curves, arg1), 1);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::coin::total_supply<T0>(&arg2) == 0, 3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(arg2, @0x0);
        let v1 = 0x2::object::new(arg3);
        let v2 = 0x2::object::uid_to_address(&v1);
        let v3 = BondingCurve<T0>{
            id                     : v1,
            creator                : v0,
            xid                    : arg1,
            reserved_token         : 0x2::coin::mint_balance<T0>(&mut arg2, arg0.token_total_supply - arg0.initial_real_token_reserves),
            virtual_token_reserves : arg0.initial_virtual_token_reserves,
            virtual_sui_reserves   : arg0.initial_virtual_sui_reserves,
            real_token_reserves    : 0x2::coin::mint_balance<T0>(&mut arg2, arg0.initial_real_token_reserves),
            real_sui_reserves      : 0x2::balance::zero<0x2::sui::SUI>(),
            token_total_supply     : arg0.token_total_supply,
            complete               : false,
        };
        0x2::table::add<u64, address>(&mut arg0.bonding_curves, arg1, v2);
        let v4 = CreateEvent{
            creator       : v0,
            bonding_curve : v2,
            token         : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            xid           : arg1,
        };
        0x2::event::emit<CreateEvent>(v4);
        v3
    }

    public fun get_buy_amount_by_sui<T0>(arg0: &BondingCurve<T0>, arg1: u64) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.real_token_reserves);
        let v1 = (arg0.virtual_token_reserves as u128) * (arg0.virtual_sui_reserves as u128);
        let v2 = (arg0.virtual_sui_reserves as u128) + (arg1 as u128);
        let v3 = if (v1 % v2 == 0) {
            v1 / v2
        } else {
            v1 / v2 + 1
        };
        let v4 = arg0.virtual_token_reserves - (v3 as u64);
        let v5 = v4;
        if (v4 > v0) {
            v5 = v0;
        };
        v5
    }

    public fun get_buy_amount_by_token<T0>(arg0: &BondingCurve<T0>, arg1: u64) : (u64, u64, u64) {
        let v0 = 0x2::balance::value<T0>(&arg0.real_token_reserves);
        let v1 = arg1;
        if (arg1 > v0) {
            v1 = v0;
        };
        let v2 = (arg0.virtual_token_reserves as u128) * (arg0.virtual_sui_reserves as u128);
        let v3 = (arg0.virtual_token_reserves as u128) - (v1 as u128);
        let v4 = if (v2 % v3 == 0) {
            v2 / v3
        } else {
            v2 / v3 + 1
        };
        (((v4 - (arg0.virtual_sui_reserves as u128)) as u64), (v3 as u64), (v4 as u64))
    }

    public fun get_sell_amount_by_token<T0>(arg0: &BondingCurve<T0>, arg1: u64) : (u64, u64, u64) {
        let v0 = (arg0.virtual_token_reserves as u128) * (arg0.virtual_sui_reserves as u128);
        let v1 = (arg0.virtual_token_reserves as u128) + (arg1 as u128);
        let v2 = if (v0 % v1 == 0) {
            v0 / v1
        } else {
            v0 / v1 + 1
        };
        let v3 = (((arg0.virtual_sui_reserves as u128) - v2) as u64);
        let v4 = v3;
        let v5 = 0x2::balance::value<0x2::sui::SUI>(&arg0.real_sui_reserves);
        if (v3 > v5) {
            v4 = v5;
        };
        (v4, (v1 as u64), (v2 as u64))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Global{
            id                             : 0x2::object::new(arg0),
            version                        : 0,
            admin                          : v0,
            fee_recipient                  : v0,
            withdraw_authority             : v0,
            initial_virtual_token_reserves : 1073000000000000,
            initial_virtual_sui_reserves   : 4500000000,
            initial_real_token_reserves    : 793100000000000,
            token_total_supply             : 1000000000000000,
            fee_basis_points               : 100,
            bonding_curves                 : 0x2::table::new<u64, address>(arg0),
        };
        0x2::transfer::share_object<Global>(v1);
    }

    public fun sell<T0>(arg0: &mut Global, arg1: &mut BondingCurve<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_version(arg0);
        assert!(!arg1.complete, 7);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 8);
        let (v1, v2, v3) = get_sell_amount_by_token<T0>(arg1, v0);
        assert!(v1 >= arg3, 5);
        0x2::balance::join<T0>(&mut arg1.real_token_reserves, 0x2::coin::into_balance<T0>(arg2));
        let v4 = 0x2::balance::split<0x2::sui::SUI>(&mut arg1.real_sui_reserves, v1);
        let v5 = (((v1 as u128) * (arg0.fee_basis_points as u128) / 10000) as u64);
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v4, v5), arg4), arg0.fee_recipient);
        };
        arg1.virtual_token_reserves = v2;
        arg1.virtual_sui_reserves = v3;
        let v6 = SellEvent{
            seller        : 0x2::tx_context::sender(arg4),
            bonding_curve : 0x2::object::uid_to_address(&arg1.id),
            token         : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            token_amount  : v0,
            sui_amount    : v1,
        };
        0x2::event::emit<SellEvent>(v6);
        0x2::coin::from_balance<0x2::sui::SUI>(v4, arg4)
    }

    public entry fun sell_entry<T0>(arg0: &mut Global, arg1: &mut BondingCurve<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = sell<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun set_admin(arg0: &mut Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg2);
        arg0.admin = arg1;
    }

    public fun set_config(arg0: &mut Global, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg6);
        arg0.initial_virtual_token_reserves = arg1;
        arg0.initial_virtual_sui_reserves = arg2;
        arg0.initial_real_token_reserves = arg3;
        arg0.token_total_supply = arg4;
        arg0.fee_basis_points = arg5;
    }

    public fun set_fee_recipient(arg0: &mut Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg2);
        arg0.fee_recipient = arg1;
    }

    public fun set_version(arg0: &mut Global, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg2);
        arg0.version = arg1;
    }

    public fun set_withdraw_authority(arg0: &mut Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg2);
        arg0.withdraw_authority = arg1;
    }

    public fun update_coin_metadata<T0>(arg0: 0x1::ascii::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::ascii::String, arg4: &0x2::coin::TreasuryCap<T0>, arg5: &mut 0x2::coin::CoinMetadata<T0>) {
        0x2::coin::update_name<T0>(arg4, arg5, arg1);
        0x2::coin::update_symbol<T0>(arg4, arg5, arg0);
        0x2::coin::update_description<T0>(arg4, arg5, arg2);
        0x2::coin::update_icon_url<T0>(arg4, arg5, arg3);
    }

    public fun withdraw<T0>(arg0: &mut Global, arg1: &mut BondingCurve<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        assert_version(arg0);
        assert!(arg1.complete, 9);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.withdraw_authority, 0);
        let v1 = 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.reserved_token), arg2);
        let v2 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.real_sui_reserves), arg2);
        let v3 = WithdrawEvent{
            withdrawer    : v0,
            bonding_curve : 0x2::object::uid_to_address(&arg1.id),
            token         : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            sui_amount    : 0x2::coin::value<0x2::sui::SUI>(&v2),
            token_amount  : 0x2::coin::value<T0>(&v1),
        };
        0x2::event::emit<WithdrawEvent>(v3);
        (v2, v1)
    }

    public entry fun withdraw_entry<T0>(arg0: &mut Global, arg1: &mut BondingCurve<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = withdraw<T0>(arg0, arg1, arg2);
        let v2 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, v2);
    }

    // decompiled from Move bytecode v6
}

