module 0xbc58fdd7922614343cde4e5180262d112c9ec8bc08a43a0cf80defa3a2ad55b6::launchpad {
    struct WalletDfKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PreSaleConfig has store {
        min_deposit_per_account: u64,
        max_deposit_per_account: u64,
        min_sale_amount: u64,
        max_sale_amount: u64,
        fixed_price: u64,
        soft_cap: u64,
        hard_cap: u64,
        started_at_ms: u64,
        ended_at_ms: u64,
        total_deposit_amount: u64,
        xflx_ratio: u64,
        refunded: 0x2::table::Table<address, bool>,
        balances: 0x2::table::Table<address, u64>,
        whitelist: 0x2::table::Table<address, bool>,
    }

    struct PublicSaleConfig has store {
        min_deposit_per_account: u64,
        max_deposit_per_account: u64,
        fixed_sale_amount: u64,
        min_price: u64,
        max_price: u64,
        soft_cap: u64,
        hard_cap: u64,
        started_at_ms: u64,
        ended_at_ms: u64,
        total_deposit_amount: u64,
        xflx_ratio: u64,
        balances: 0x2::table::Table<address, u64>,
    }

    struct Launchpad<phantom T0> has store, key {
        id: 0x2::object::UID,
        pre_sale_config: PreSaleConfig,
        public_sale_config: PublicSaleConfig,
        claimable: bool,
        is_paused: bool,
        version: u64,
    }

    struct DepositPreSale has copy, drop {
        amount: u64,
        sender: address,
    }

    struct ClaimPreSale has copy, drop {
        flx_amount: u64,
        refund_amount: u64,
        sender: address,
    }

    struct DepositPublicSale has copy, drop {
        amount: u64,
        sender: address,
        referral_code: vector<u8>,
    }

    struct WithdrawPublicSale has copy, drop {
        amount: u64,
        sender: address,
    }

    struct ClaimPublicSale has copy, drop {
        flx_amount: u64,
        refund_amount: u64,
        sender: address,
    }

    fun new<T0: drop>(arg0: PreSaleConfig, arg1: PublicSaleConfig, arg2: &mut 0x2::tx_context::TxContext) : Launchpad<T0> {
        let v0 = Launchpad<T0>{
            id                 : 0x2::object::new(arg2),
            pre_sale_config    : arg0,
            public_sale_config : arg1,
            claimable          : false,
            is_paused          : false,
            version            : 1,
        };
        let v1 = WalletDfKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<WalletDfKey<T0>, 0x2::balance::Balance<T0>>(&mut v0.id, v1, 0x2::balance::zero<T0>());
        let v2 = WalletDfKey<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>{dummy_field: false};
        0x2::dynamic_field::add<WalletDfKey<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>, 0x2::balance::Balance<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>>(&mut v0.id, v2, 0x2::balance::zero<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>());
        v0
    }

    fun assert_version<T0>(arg0: &Launchpad<T0>) {
        assert!(arg0.version == 1, 999);
    }

    fun assert_version_and_upgrade<T0>(arg0: &mut Launchpad<T0>) {
        if (arg0.version < 1) {
            arg0.version = 1;
        };
        assert_version<T0>(arg0);
    }

    public fun balance_of<T0>(arg0: &Launchpad<T0>, arg1: address) : u64 {
        let v0 = if (!0x2::table::contains<address, u64>(&arg0.pre_sale_config.balances, arg1)) {
            0
        } else {
            *0x2::table::borrow<address, u64>(&arg0.pre_sale_config.balances, arg1)
        };
        let v1 = if (!0x2::table::contains<address, u64>(&arg0.public_sale_config.balances, arg1)) {
            0
        } else {
            *0x2::table::borrow<address, u64>(&arg0.public_sale_config.balances, arg1)
        };
        v0 + v1
    }

    public entry fun claim_fund_pre_sale<T0>(arg0: &mut Launchpad<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 9);
        assert_version_and_upgrade<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.pre_sale_config.ended_at_ms, 11);
        assert!(!0x2::table::contains<address, bool>(&arg0.pre_sale_config.refunded, v0), 12);
        claim_fund_pre_sale_for<T0>(arg0, v0, arg2);
    }

    fun claim_fund_pre_sale_for<T0>(arg0: &mut Launchpad<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x2::table::borrow<address, u64>(&arg0.pre_sale_config.balances, arg1);
        let v1 = if (arg0.pre_sale_config.total_deposit_amount <= arg0.pre_sale_config.soft_cap) {
            v0
        } else if (arg0.pre_sale_config.total_deposit_amount <= arg0.pre_sale_config.hard_cap) {
            0
        } else {
            v0 - 0xbc58fdd7922614343cde4e5180262d112c9ec8bc08a43a0cf80defa3a2ad55b6::u64::mul_div(0xbc58fdd7922614343cde4e5180262d112c9ec8bc08a43a0cf80defa3a2ad55b6::u64::mul_div(v0, arg0.pre_sale_config.max_sale_amount, arg0.pre_sale_config.total_deposit_amount), arg0.pre_sale_config.fixed_price, 100000000) + 1
        };
        0x2::table::add<address, bool>(&mut arg0.pre_sale_config.refunded, arg1, true);
        if (v1 > 0) {
            let v2 = WalletDfKey<T0>{dummy_field: false};
            let v3 = 0x2::dynamic_field::borrow_mut<WalletDfKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(safe_withdraw<T0>(v3, v1), arg2), arg1);
        };
        let v4 = ClaimPreSale{
            flx_amount    : 0,
            refund_amount : v1,
            sender        : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ClaimPreSale>(v4);
    }

    public entry fun claim_pre_sale<T0>(arg0: &mut Launchpad<T0>, arg1: &mut 0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::TreasuryManagement, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 9);
        assert_version_and_upgrade<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.claimable, 6);
        assert!(0x2::table::contains<address, u64>(&arg0.pre_sale_config.balances, v0) && *0x2::table::borrow<address, u64>(&arg0.pre_sale_config.balances, v0) > 0, 4);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = *0x2::table::borrow<address, u64>(&arg0.pre_sale_config.balances, v1);
        let v3 = if (arg0.pre_sale_config.total_deposit_amount <= arg0.pre_sale_config.soft_cap) {
            0
        } else if (arg0.pre_sale_config.total_deposit_amount <= arg0.pre_sale_config.hard_cap) {
            0xbc58fdd7922614343cde4e5180262d112c9ec8bc08a43a0cf80defa3a2ad55b6::u64::mul_div(v2, 100000000, arg0.pre_sale_config.fixed_price)
        } else {
            0xbc58fdd7922614343cde4e5180262d112c9ec8bc08a43a0cf80defa3a2ad55b6::u64::mul_div(v2, arg0.pre_sale_config.max_sale_amount, arg0.pre_sale_config.total_deposit_amount)
        };
        if (v3 > 0) {
            let v4 = WalletDfKey<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>{dummy_field: false};
            let v5 = 0x2::dynamic_field::borrow_mut<WalletDfKey<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>, 0x2::balance::Balance<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>>(&mut arg0.id, v4);
            let v6 = safe_withdraw<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(v5, v3);
            0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::mint_and_transfer(arg1, 0x2::coin::from_balance<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(0x2::balance::split<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(&mut v6, 0xbc58fdd7922614343cde4e5180262d112c9ec8bc08a43a0cf80defa3a2ad55b6::u64::mul_div(v3, arg0.pre_sale_config.xflx_ratio, 10000)), arg2), v1, arg2);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>>(0x2::coin::from_balance<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(v6, arg2), v1);
        };
        let v7 = ClaimPreSale{
            flx_amount    : v3,
            refund_amount : 0,
            sender        : v1,
        };
        0x2::event::emit<ClaimPreSale>(v7);
        if (!0x2::table::contains<address, bool>(&arg0.pre_sale_config.refunded, v1)) {
            claim_fund_pre_sale_for<T0>(arg0, v1, arg2);
        };
        let v8 = &mut arg0.pre_sale_config.balances;
        decrease_balance(v8, v1, v2);
    }

    public entry fun claim_public_sale<T0>(arg0: &mut Launchpad<T0>, arg1: &mut 0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::TreasuryManagement, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 9);
        assert_version_and_upgrade<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.claimable, 6);
        assert!(0x2::table::contains<address, u64>(&arg0.public_sale_config.balances, v0) && *0x2::table::borrow<address, u64>(&arg0.public_sale_config.balances, v0) > 0, 4);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = *0x2::table::borrow<address, u64>(&arg0.public_sale_config.balances, v1);
        let (v3, v4) = if (arg0.public_sale_config.total_deposit_amount <= arg0.public_sale_config.soft_cap) {
            (0xbc58fdd7922614343cde4e5180262d112c9ec8bc08a43a0cf80defa3a2ad55b6::u64::mul_div(v2, 100000000, arg0.public_sale_config.min_price), 0)
        } else if (arg0.public_sale_config.total_deposit_amount <= arg0.public_sale_config.hard_cap) {
            (0xbc58fdd7922614343cde4e5180262d112c9ec8bc08a43a0cf80defa3a2ad55b6::u64::mul_div(v2, 100000000, 0xbc58fdd7922614343cde4e5180262d112c9ec8bc08a43a0cf80defa3a2ad55b6::u64::mul_div(arg0.public_sale_config.total_deposit_amount, 100000000, arg0.public_sale_config.fixed_sale_amount)), 0)
        } else {
            let v5 = 0xbc58fdd7922614343cde4e5180262d112c9ec8bc08a43a0cf80defa3a2ad55b6::u64::mul_div(v2, arg0.public_sale_config.fixed_sale_amount, arg0.public_sale_config.total_deposit_amount);
            (v5, v2 - 0xbc58fdd7922614343cde4e5180262d112c9ec8bc08a43a0cf80defa3a2ad55b6::u64::mul_div(v5, arg0.public_sale_config.max_price, 100000000) + 1)
        };
        let v6 = &mut arg0.public_sale_config.balances;
        decrease_balance(v6, v1, v2);
        if (v4 > 0) {
            let v7 = WalletDfKey<T0>{dummy_field: false};
            let v8 = 0x2::dynamic_field::borrow_mut<WalletDfKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v7);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(safe_withdraw<T0>(v8, v4), arg2), v1);
        };
        if (v3 > 0) {
            let v9 = WalletDfKey<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>{dummy_field: false};
            let v10 = 0x2::dynamic_field::borrow_mut<WalletDfKey<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>, 0x2::balance::Balance<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>>(&mut arg0.id, v9);
            let v11 = safe_withdraw<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(v10, v3);
            0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::mint_and_transfer(arg1, 0x2::coin::from_balance<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(0x2::balance::split<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(&mut v11, 0xbc58fdd7922614343cde4e5180262d112c9ec8bc08a43a0cf80defa3a2ad55b6::u64::mul_div(v3, arg0.public_sale_config.xflx_ratio, 10000)), arg2), v1, arg2);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>>(0x2::coin::from_balance<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(v11, arg2), v1);
        };
        let v12 = ClaimPublicSale{
            flx_amount    : v3,
            refund_amount : v4,
            sender        : v1,
        };
        0x2::event::emit<ClaimPublicSale>(v12);
    }

    fun decrease_balance(arg0: &mut 0x2::table::Table<address, u64>, arg1: address, arg2: u64) {
        let v0 = 0x2::table::borrow_mut<address, u64>(arg0, arg1);
        *v0 = *v0 - arg2;
    }

    public entry fun deposit_as_admin<T0, T1>(arg0: &AdminCap, arg1: &mut Launchpad<T0>, arg2: 0x2::coin::Coin<T1>) {
        let v0 = WalletDfKey<T1>{dummy_field: false};
        0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<WalletDfKey<T1>, 0x2::balance::Balance<T1>>(&mut arg1.id, v0), 0x2::coin::into_balance<T1>(arg2));
    }

    public entry fun grant_whitelist<T0>(arg0: &AdminCap, arg1: &mut Launchpad<T0>, arg2: vector<address>, arg3: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg3) < arg1.pre_sale_config.started_at_ms, 7);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            if (!0x2::table::contains<address, bool>(&arg1.pre_sale_config.whitelist, v1)) {
                0x2::table::add<address, bool>(&mut arg1.pre_sale_config.whitelist, v1, true);
            };
            v0 = v0 + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun initialize<T0: drop>(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        let v0 = PreSaleConfig{
            min_deposit_per_account : arg1,
            max_deposit_per_account : arg2,
            min_sale_amount         : arg3,
            max_sale_amount         : arg4,
            fixed_price             : arg5,
            soft_cap                : 0,
            hard_cap                : 0,
            started_at_ms           : arg6,
            ended_at_ms             : arg7,
            total_deposit_amount    : 0,
            xflx_ratio              : arg8,
            refunded                : 0x2::table::new<address, bool>(arg17),
            balances                : 0x2::table::new<address, u64>(arg17),
            whitelist               : 0x2::table::new<address, bool>(arg17),
        };
        v0.soft_cap = 0xbc58fdd7922614343cde4e5180262d112c9ec8bc08a43a0cf80defa3a2ad55b6::u64::mul_div(v0.fixed_price, v0.min_sale_amount, 100000000);
        v0.hard_cap = 0xbc58fdd7922614343cde4e5180262d112c9ec8bc08a43a0cf80defa3a2ad55b6::u64::mul_div(v0.fixed_price, v0.max_sale_amount, 100000000);
        let v1 = PublicSaleConfig{
            min_deposit_per_account : arg9,
            max_deposit_per_account : arg10,
            fixed_sale_amount       : arg11,
            min_price               : arg12,
            max_price               : arg13,
            soft_cap                : 0,
            hard_cap                : 0,
            started_at_ms           : arg14,
            ended_at_ms             : arg15,
            total_deposit_amount    : 0,
            xflx_ratio              : arg16,
            balances                : 0x2::table::new<address, u64>(arg17),
        };
        v1.soft_cap = 0xbc58fdd7922614343cde4e5180262d112c9ec8bc08a43a0cf80defa3a2ad55b6::u64::mul_div(v1.fixed_sale_amount, v1.min_price, 100000000);
        v1.hard_cap = 0xbc58fdd7922614343cde4e5180262d112c9ec8bc08a43a0cf80defa3a2ad55b6::u64::mul_div(v1.fixed_sale_amount, v1.max_price, 100000000);
        0x2::transfer::share_object<Launchpad<T0>>(new<T0>(v0, v1, arg17));
    }

    public entry fun pause<T0>(arg0: &AdminCap, arg1: &mut Launchpad<T0>) {
        assert!(!arg1.is_paused, 9);
        arg1.is_paused = true;
    }

    public entry fun pre_sale_deposit<T0>(arg0: &mut Launchpad<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 9);
        assert_version_and_upgrade<T0>(arg0);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.pre_sale_config.started_at_ms, 0);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.pre_sale_config.ended_at_ms, 1);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, bool>(&arg0.pre_sale_config.whitelist, v0), 5);
        if (!0x2::table::contains<address, u64>(&arg0.pre_sale_config.balances, v0)) {
            0x2::table::add<address, u64>(&mut arg0.pre_sale_config.balances, v0, 0);
        };
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 >= arg0.pre_sale_config.min_deposit_per_account, 2);
        assert!(*0x2::table::borrow<address, u64>(&arg0.pre_sale_config.balances, v0) + v1 <= arg0.pre_sale_config.max_deposit_per_account, 3);
        let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg0.pre_sale_config.balances, v0);
        *v2 = *v2 + v1;
        let v3 = WalletDfKey<T0>{dummy_field: false};
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<WalletDfKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v3), 0x2::coin::into_balance<T0>(arg1));
        arg0.pre_sale_config.total_deposit_amount = arg0.pre_sale_config.total_deposit_amount + v1;
        let v4 = DepositPreSale{
            amount : v1,
            sender : v0,
        };
        0x2::event::emit<DepositPreSale>(v4);
    }

    public fun pre_sale_hard_cap<T0>(arg0: &Launchpad<T0>) : u64 {
        arg0.pre_sale_config.hard_cap
    }

    public fun pre_sale_is_refunded<T0>(arg0: &Launchpad<T0>, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.pre_sale_config.refunded, arg1)
    }

    public fun pre_sale_soft_cap<T0>(arg0: &Launchpad<T0>) : u64 {
        arg0.pre_sale_config.soft_cap
    }

    public entry fun public_sale_deposit<T0>(arg0: &mut Launchpad<T0>, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 9);
        assert_version_and_upgrade<T0>(arg0);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.public_sale_config.started_at_ms, 0);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.public_sale_config.ended_at_ms, 1);
        let v0 = 0x2::tx_context::sender(arg4);
        if (!0x2::table::contains<address, u64>(&arg0.public_sale_config.balances, v0)) {
            0x2::table::add<address, u64>(&mut arg0.public_sale_config.balances, v0, 0);
        };
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 >= arg0.public_sale_config.min_deposit_per_account, 2);
        assert!(*0x2::table::borrow<address, u64>(&arg0.public_sale_config.balances, v0) + v1 <= arg0.public_sale_config.max_deposit_per_account, 3);
        let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg0.public_sale_config.balances, v0);
        *v2 = *v2 + v1;
        let v3 = WalletDfKey<T0>{dummy_field: false};
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<WalletDfKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v3), 0x2::coin::into_balance<T0>(arg1));
        arg0.public_sale_config.total_deposit_amount = arg0.public_sale_config.total_deposit_amount + v1;
        let v4 = DepositPublicSale{
            amount        : v1,
            sender        : v0,
            referral_code : arg2,
        };
        0x2::event::emit<DepositPublicSale>(v4);
    }

    public fun public_sale_hard_cap<T0>(arg0: &Launchpad<T0>) : u64 {
        arg0.public_sale_config.hard_cap
    }

    public fun public_sale_soft_cap<T0>(arg0: &Launchpad<T0>) : u64 {
        arg0.public_sale_config.soft_cap
    }

    public entry fun public_sale_withdraw<T0>(arg0: &mut Launchpad<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 9);
        assert_version_and_upgrade<T0>(arg0);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.public_sale_config.started_at_ms, 0);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.public_sale_config.ended_at_ms, 1);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, u64>(&arg0.public_sale_config.balances, v0) && *0x2::table::borrow<address, u64>(&arg0.public_sale_config.balances, v0) >= arg1, 4);
        assert!(*0x2::table::borrow<address, u64>(&arg0.public_sale_config.balances, v0) - arg1 >= arg0.public_sale_config.min_deposit_per_account, 2);
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.public_sale_config.balances, v0);
        *v1 = *v1 - arg1;
        let v2 = WalletDfKey<T0>{dummy_field: false};
        arg0.public_sale_config.total_deposit_amount = arg0.public_sale_config.total_deposit_amount - arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<WalletDfKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v2), arg1), arg3), v0);
        let v3 = WithdrawPublicSale{
            amount : arg1,
            sender : v0,
        };
        0x2::event::emit<WithdrawPublicSale>(v3);
    }

    public entry fun revoke_whitelist<T0>(arg0: &AdminCap, arg1: &mut Launchpad<T0>, arg2: vector<address>, arg3: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg3) < arg1.pre_sale_config.started_at_ms, 7);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            if (0x2::table::contains<address, bool>(&arg1.pre_sale_config.whitelist, v1)) {
                0x2::table::remove<address, bool>(&mut arg1.pre_sale_config.whitelist, v1);
            };
            v0 = v0 + 1;
        };
    }

    fun safe_withdraw<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T0>(arg0);
        if (arg1 > v0) {
            0x2::balance::split<T0>(arg0, v0)
        } else {
            0x2::balance::split<T0>(arg0, arg1)
        }
    }

    public entry fun set_claimable<T0>(arg0: &AdminCap, arg1: &mut Launchpad<T0>, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) > arg1.public_sale_config.ended_at_ms, 8);
        arg1.claimable = true;
    }

    public entry fun set_max_deposit_public_sale<T0>(arg0: &AdminCap, arg1: &mut Launchpad<T0>, arg2: u64) {
        arg1.public_sale_config.max_deposit_per_account = arg2;
    }

    public entry fun set_min_deposit_public_sale<T0>(arg0: &AdminCap, arg1: &mut Launchpad<T0>, arg2: u64) {
        arg1.public_sale_config.min_deposit_per_account = arg2;
    }

    public fun total_deposit_amount<T0>(arg0: &Launchpad<T0>) : u64 {
        arg0.pre_sale_config.total_deposit_amount + arg0.public_sale_config.total_deposit_amount
    }

    public entry fun unpause<T0>(arg0: &AdminCap, arg1: &mut Launchpad<T0>) {
        assert!(arg1.is_paused, 10);
        arg1.is_paused = false;
    }

    public entry fun upgrade<T0>(arg0: &AdminCap, arg1: &mut Launchpad<T0>) {
        assert!(arg1.version < 1, 1000);
        arg1.version = 1;
    }

    public fun wallet_balance<T0, T1>(arg0: &Launchpad<T0>) : u64 {
        let v0 = WalletDfKey<T1>{dummy_field: false};
        0x2::balance::value<T1>(0x2::dynamic_field::borrow<WalletDfKey<T1>, 0x2::balance::Balance<T1>>(&arg0.id, v0))
    }

    public entry fun withdraw_flx_as_admin<T0>(arg0: &AdminCap, arg1: &mut Launchpad<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) > arg1.public_sale_config.ended_at_ms, 8);
        let v0 = if (arg1.pre_sale_config.total_deposit_amount <= arg1.pre_sale_config.soft_cap) {
            arg1.pre_sale_config.max_sale_amount
        } else if (arg1.pre_sale_config.total_deposit_amount <= arg1.pre_sale_config.hard_cap) {
            arg1.pre_sale_config.max_sale_amount - 0xbc58fdd7922614343cde4e5180262d112c9ec8bc08a43a0cf80defa3a2ad55b6::u64::mul_div(arg1.pre_sale_config.total_deposit_amount, 100000000, arg1.pre_sale_config.fixed_price)
        } else {
            0
        };
        let v1 = if (arg1.public_sale_config.total_deposit_amount <= arg1.public_sale_config.soft_cap) {
            arg1.public_sale_config.fixed_sale_amount - 0xbc58fdd7922614343cde4e5180262d112c9ec8bc08a43a0cf80defa3a2ad55b6::u64::mul_div(arg1.public_sale_config.total_deposit_amount, 100000000, arg1.public_sale_config.min_price)
        } else if (arg1.public_sale_config.total_deposit_amount <= arg1.public_sale_config.hard_cap) {
            arg1.public_sale_config.fixed_sale_amount - 0xbc58fdd7922614343cde4e5180262d112c9ec8bc08a43a0cf80defa3a2ad55b6::u64::mul_div(arg1.public_sale_config.total_deposit_amount, 100000000, 0xbc58fdd7922614343cde4e5180262d112c9ec8bc08a43a0cf80defa3a2ad55b6::u64::mul_div(arg1.public_sale_config.total_deposit_amount, 100000000, arg1.public_sale_config.fixed_sale_amount))
        } else {
            0
        };
        let v2 = WalletDfKey<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<WalletDfKey<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>, 0x2::balance::Balance<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>>(&mut arg1.id, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>>(0x2::coin::from_balance<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(safe_withdraw<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(v3, v0 + v1), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_fund_as_admin<T0>(arg0: &AdminCap, arg1: &mut Launchpad<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) > arg1.public_sale_config.ended_at_ms, 8);
        let v0 = if (arg1.pre_sale_config.total_deposit_amount <= arg1.pre_sale_config.soft_cap) {
            0
        } else if (arg1.pre_sale_config.total_deposit_amount <= arg1.pre_sale_config.hard_cap) {
            arg1.pre_sale_config.total_deposit_amount
        } else {
            arg1.pre_sale_config.hard_cap
        };
        let v1 = if (arg1.public_sale_config.total_deposit_amount <= arg1.public_sale_config.hard_cap) {
            arg1.public_sale_config.total_deposit_amount
        } else {
            arg1.public_sale_config.hard_cap
        };
        let v2 = WalletDfKey<T0>{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<WalletDfKey<T0>, 0x2::balance::Balance<T0>>(&mut arg1.id, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(safe_withdraw<T0>(v3, v0 + v1), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

