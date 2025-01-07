module 0x363c72819606940d665c57123ea435a1eabe27e7fac1f517f76fcd713f867258::voucher {
    struct Voucher<phantom T0> has key {
        id: 0x2::object::UID,
        info: VoucherInfo,
    }

    struct SponsorPool<phantom T0> has key {
        id: 0x2::object::UID,
        asset: 0x2::balance::Balance<T0>,
        sponsor_addr: 0x1::option::Option<address>,
        settings: 0x1::option::Option<SponsorPoolSettings>,
    }

    struct VoucherInfo has drop, store {
        amount: u64,
        deadline: u64,
        sponsor_addr: 0x1::option::Option<address>,
    }

    struct SponsorPoolSettings has store {
        mint_times: u64,
        amount_per_time: u64,
        deadline: u64,
        allocated: u64,
        remaining: u64,
        record: 0x2::table::Table<address, u64>,
    }

    struct VoucherConsumeRequest<phantom T0> {
        request_amount: u64,
        base_provider: 0x2::object::ID,
        sponsor_addr: 0x1::option::Option<address>,
    }

    struct PoolCap has key {
        id: 0x2::object::UID,
    }

    struct SendAdminVoucher has copy, drop {
        voucher_id: 0x2::object::ID,
        amount: u64,
        deadline: u64,
    }

    struct MintedFundManagerVoucher has copy, drop {
        voucher_id: 0x2::object::ID,
        sponsor_addr: address,
        amount: u64,
        deadline: u64,
    }

    struct CreatedSponsorPool<phantom T0> has copy, drop {
        id: 0x2::object::ID,
        init_asset_amount: u64,
        sponsor_addr: 0x1::option::Option<address>,
    }

    struct DepositedSponsorPool<phantom T0> has copy, drop {
        pool: 0x2::object::ID,
        sponsor_addr: 0x1::option::Option<address>,
        amount: u64,
    }

    struct PutBack<phantom T0> has copy, drop {
        pool: 0x2::object::ID,
        amount: u64,
    }

    public fun admin_mint_to<T0>(arg0: &0x363c72819606940d665c57123ea435a1eabe27e7fac1f517f76fcd713f867258::config::GlobalConfig, arg1: &0x363c72819606940d665c57123ea435a1eabe27e7fac1f517f76fcd713f867258::config::AdminCap, arg2: vector<address>, arg3: vector<u64>, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        0x363c72819606940d665c57123ea435a1eabe27e7fac1f517f76fcd713f867258::config::assert_if_version_not_matched(arg0, 1);
        while (0x1::vector::length<address>(&arg2) > 0) {
            let v0 = mint<T0>(0x1::vector::pop_back<u64>(&mut arg3), 0x1::vector::pop_back<u64>(&mut arg4), 0x1::option::none<address>(), arg5);
            let v1 = SendAdminVoucher{
                voucher_id : *0x2::object::uid_as_inner(&v0.id),
                amount     : v0.info.amount,
                deadline   : v0.info.deadline,
            };
            0x2::event::emit<SendAdminVoucher>(v1);
            0x2::transfer::transfer<Voucher<T0>>(v0, 0x1::vector::pop_back<address>(&mut arg2));
        };
    }

    fun assert_if_over_mint_times<T0>(arg0: &SponsorPool<T0>, arg1: address) {
        if (0x2::table::contains<address, u64>(&0x1::option::borrow<SponsorPoolSettings>(&arg0.settings).record, arg1)) {
            assert!(*0x2::table::borrow<address, u64>(&0x1::option::borrow<SponsorPoolSettings>(&arg0.settings).record, arg1) < 0x1::option::borrow<SponsorPoolSettings>(&arg0.settings).mint_times, 2);
        };
    }

    fun assert_if_pool_balance_not_enough<T0>(arg0: &SponsorPool<T0>, arg1: u64) {
        assert!(0x2::balance::value<T0>(&arg0.asset) >= arg1, 0);
    }

    fun assert_if_pool_owner_not_matched<T0>(arg0: &SponsorPool<T0>, arg1: address) {
        assert!(!0x1::option::is_none<address>(&arg0.sponsor_addr), 3);
        assert!(*0x1::option::borrow<address>(&arg0.sponsor_addr) == arg1, 4);
    }

    fun assert_if_remainig_amount_not_enough<T0>(arg0: &SponsorPool<T0>) {
        assert!(0x1::option::borrow<SponsorPoolSettings>(&arg0.settings).remaining >= 0x1::option::borrow<SponsorPoolSettings>(&arg0.settings).amount_per_time, 1);
    }

    public fun base_provider<T0>(arg0: &VoucherConsumeRequest<T0>) : 0x2::object::ID {
        arg0.base_provider
    }

    fun burn_and_get_voucher_amount<T0>(arg0: Voucher<T0>, arg1: &0x2::clock::Clock) : u64 {
        let Voucher {
            id   : v0,
            info : v1,
        } = arg0;
        let v2 = v1;
        0x2::object::delete(v0);
        if (v2.deadline >= 0x2::clock::timestamp_ms(arg1)) {
            v2.amount
        } else {
            0
        }
    }

    public(friend) fun burn_request<T0>(arg0: VoucherConsumeRequest<T0>) {
        let VoucherConsumeRequest {
            request_amount : _,
            base_provider  : _,
            sponsor_addr   : _,
        } = arg0;
    }

    public fun consume<T0>(arg0: &0x363c72819606940d665c57123ea435a1eabe27e7fac1f517f76fcd713f867258::config::GlobalConfig, arg1: &mut SponsorPool<T0>, arg2: vector<Voucher<T0>>, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, VoucherConsumeRequest<T0>) {
        0x363c72819606940d665c57123ea435a1eabe27e7fac1f517f76fcd713f867258::config::assert_if_version_not_matched(arg0, 1);
        let v0 = 0;
        while (0x1::vector::length<Voucher<T0>>(&arg2) != 0) {
            let v1 = 0x1::vector::pop_back<Voucher<T0>>(&mut arg2);
            assert!(0x1::option::is_none<address>(&v1.info.sponsor_addr) == 0x1::option::is_none<address>(&0x1::vector::borrow<Voucher<T0>>(&arg2, 0).info.sponsor_addr), 5);
            v0 = v0 + burn_and_get_voucher_amount<T0>(v1, arg3);
        };
        0x1::vector::destroy_empty<Voucher<T0>>(arg2);
        assert_if_pool_balance_not_enough<T0>(arg1, v0);
        let v2 = VoucherConsumeRequest<T0>{
            request_amount : v0,
            base_provider  : *0x2::object::uid_as_inner(&arg1.id),
            sponsor_addr   : 0x1::vector::borrow<Voucher<T0>>(&arg2, 0).info.sponsor_addr,
        };
        (0x2::balance::split<T0>(&mut arg1.asset, v0), v2)
    }

    public fun deposit_to_admin_pool<T0>(arg0: &0x363c72819606940d665c57123ea435a1eabe27e7fac1f517f76fcd713f867258::config::GlobalConfig, arg1: &0x363c72819606940d665c57123ea435a1eabe27e7fac1f517f76fcd713f867258::config::AdminCap, arg2: &mut SponsorPool<T0>, arg3: 0x2::coin::Coin<T0>) {
        0x363c72819606940d665c57123ea435a1eabe27e7fac1f517f76fcd713f867258::config::assert_if_version_not_matched(arg0, 1);
        0x2::balance::join<T0>(&mut arg2.asset, 0x2::coin::into_balance<T0>(arg3));
        let v0 = DepositedSponsorPool<T0>{
            pool         : *0x2::object::uid_as_inner(&arg2.id),
            sponsor_addr : 0x1::option::none<address>(),
            amount       : 0x2::coin::value<T0>(&arg3),
        };
        0x2::event::emit<DepositedSponsorPool<T0>>(v0);
    }

    public fun deposit_to_fund_manager_pool<T0>(arg0: &0x363c72819606940d665c57123ea435a1eabe27e7fac1f517f76fcd713f867258::config::GlobalConfig, arg1: &mut SponsorPool<T0>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::tx_context::TxContext) {
        0x363c72819606940d665c57123ea435a1eabe27e7fac1f517f76fcd713f867258::config::assert_if_version_not_matched(arg0, 1);
        assert_if_pool_owner_not_matched<T0>(arg1, 0x2::tx_context::sender(arg3));
        let v0 = 0x2::balance::value<T0>(&arg2);
        0x2::balance::join<T0>(&mut arg1.asset, arg2);
        let v1 = 0x1::option::borrow_mut<SponsorPoolSettings>(&mut arg1.settings);
        v1.remaining = v1.remaining + v0;
        let v2 = DepositedSponsorPool<T0>{
            pool         : *0x2::object::uid_as_inner(&arg1.id),
            sponsor_addr : arg1.sponsor_addr,
            amount       : v0,
        };
        0x2::event::emit<DepositedSponsorPool<T0>>(v2);
    }

    fun mint<T0>(arg0: u64, arg1: u64, arg2: 0x1::option::Option<address>, arg3: &mut 0x2::tx_context::TxContext) : Voucher<T0> {
        let v0 = VoucherInfo{
            amount       : arg0,
            deadline     : arg1,
            sponsor_addr : arg2,
        };
        Voucher<T0>{
            id   : 0x2::object::new(arg3),
            info : v0,
        }
    }

    public fun mint_fund_manager_voucher<T0>(arg0: &0x363c72819606940d665c57123ea435a1eabe27e7fac1f517f76fcd713f867258::config::GlobalConfig, arg1: &mut SponsorPool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x363c72819606940d665c57123ea435a1eabe27e7fac1f517f76fcd713f867258::config::assert_if_version_not_matched(arg0, 1);
        assert_if_remainig_amount_not_enough<T0>(arg1);
        assert_if_over_mint_times<T0>(arg1, 0x2::tx_context::sender(arg2));
        let v0 = 0x1::option::borrow<SponsorPoolSettings>(&arg1.settings).amount_per_time;
        let v1 = mint<T0>(v0, 0x1::option::borrow<SponsorPoolSettings>(&arg1.settings).deadline, 0x1::option::some<address>(*0x1::option::borrow<address>(&arg1.sponsor_addr)), arg2);
        let v2 = 0x1::option::borrow_mut<SponsorPoolSettings>(&mut arg1.settings);
        let v3 = 0;
        if (0x2::table::contains<address, u64>(&v2.record, 0x2::tx_context::sender(arg2))) {
            v3 = 0x2::table::remove<address, u64>(&mut v2.record, 0x2::tx_context::sender(arg2));
        };
        0x2::table::add<address, u64>(&mut v2.record, 0x2::tx_context::sender(arg2), v3 + 1);
        v2.remaining = v2.remaining - v0;
        v2.allocated = v2.allocated + v0;
        let v4 = MintedFundManagerVoucher{
            voucher_id   : *0x2::object::uid_as_inner(&v1.id),
            sponsor_addr : *0x1::option::borrow<address>(&arg1.sponsor_addr),
            amount       : v1.info.amount,
            deadline     : v1.info.deadline,
        };
        0x2::event::emit<MintedFundManagerVoucher>(v4);
        0x2::transfer::transfer<Voucher<T0>>(v1, 0x2::tx_context::sender(arg2));
    }

    public fun new_admin_sponsor_pool<T0>(arg0: &0x363c72819606940d665c57123ea435a1eabe27e7fac1f517f76fcd713f867258::config::GlobalConfig, arg1: &0x363c72819606940d665c57123ea435a1eabe27e7fac1f517f76fcd713f867258::config::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        0x363c72819606940d665c57123ea435a1eabe27e7fac1f517f76fcd713f867258::config::assert_if_version_not_matched(arg0, 1);
        let v0 = SponsorPool<T0>{
            id           : 0x2::object::new(arg2),
            asset        : 0x2::balance::zero<T0>(),
            sponsor_addr : 0x1::option::none<address>(),
            settings     : 0x1::option::none<SponsorPoolSettings>(),
        };
        let v1 = CreatedSponsorPool<T0>{
            id                : *0x2::object::uid_as_inner(&v0.id),
            init_asset_amount : 0,
            sponsor_addr      : 0x1::option::none<address>(),
        };
        0x2::event::emit<CreatedSponsorPool<T0>>(v1);
        0x2::transfer::share_object<SponsorPool<T0>>(v0);
    }

    public fun new_fund_manager_sponsor_pool<T0>(arg0: &0x363c72819606940d665c57123ea435a1eabe27e7fac1f517f76fcd713f867258::config::GlobalConfig, arg1: u64, arg2: u64, arg3: u64, arg4: 0x2::balance::Balance<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        0x363c72819606940d665c57123ea435a1eabe27e7fac1f517f76fcd713f867258::config::assert_if_version_not_matched(arg0, 1);
        let v0 = 0x2::balance::value<T0>(&arg4);
        let v1 = SponsorPoolSettings{
            mint_times      : arg1,
            amount_per_time : arg2,
            deadline        : arg3,
            allocated       : 0,
            remaining       : v0,
            record          : 0x2::table::new<address, u64>(arg5),
        };
        let v2 = SponsorPool<T0>{
            id           : 0x2::object::new(arg5),
            asset        : arg4,
            sponsor_addr : 0x1::option::some<address>(0x2::tx_context::sender(arg5)),
            settings     : 0x1::option::some<SponsorPoolSettings>(v1),
        };
        let v3 = CreatedSponsorPool<T0>{
            id                : *0x2::object::uid_as_inner(&v2.id),
            init_asset_amount : v0,
            sponsor_addr      : 0x1::option::some<address>(0x2::tx_context::sender(arg5)),
        };
        0x2::event::emit<CreatedSponsorPool<T0>>(v3);
        0x2::transfer::share_object<SponsorPool<T0>>(v2);
    }

    public fun pool_sponsor_addr<T0>(arg0: &SponsorPool<T0>) : 0x1::option::Option<address> {
        if (0x1::option::is_none<address>(&arg0.sponsor_addr)) {
            0x1::option::none<address>()
        } else {
            0x1::option::some<address>(*0x1::option::borrow<address>(&arg0.sponsor_addr))
        }
    }

    public(friend) fun put_back<T0>(arg0: &mut SponsorPool<T0>, arg1: 0x2::balance::Balance<T0>) {
        let v0 = PutBack<T0>{
            pool   : *0x2::object::uid_as_inner(&arg0.id),
            amount : 0x2::balance::value<T0>(&arg1),
        };
        0x2::event::emit<PutBack<T0>>(v0);
        0x2::balance::join<T0>(&mut arg0.asset, arg1);
    }

    public fun request_amount<T0>(arg0: &VoucherConsumeRequest<T0>) : u64 {
        arg0.request_amount
    }

    public fun request_sponsor_addr<T0>(arg0: &VoucherConsumeRequest<T0>) : 0x1::option::Option<address> {
        if (0x1::option::is_none<address>(&arg0.sponsor_addr)) {
            0x1::option::none<address>()
        } else {
            0x1::option::some<address>(*0x1::option::borrow<address>(&arg0.sponsor_addr))
        }
    }

    public fun withdraw_from_admin_pool<T0>(arg0: &0x363c72819606940d665c57123ea435a1eabe27e7fac1f517f76fcd713f867258::config::GlobalConfig, arg1: &0x363c72819606940d665c57123ea435a1eabe27e7fac1f517f76fcd713f867258::config::AdminCap, arg2: &mut SponsorPool<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x363c72819606940d665c57123ea435a1eabe27e7fac1f517f76fcd713f867258::config::assert_if_version_not_matched(arg0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(withdraw_from_pool<T0>(arg2, arg3, arg4), arg5), 0x2::tx_context::sender(arg5));
    }

    public fun withdraw_from_fund_manager_pool<T0>(arg0: &0x363c72819606940d665c57123ea435a1eabe27e7fac1f517f76fcd713f867258::config::GlobalConfig, arg1: &mut SponsorPool<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x363c72819606940d665c57123ea435a1eabe27e7fac1f517f76fcd713f867258::config::assert_if_version_not_matched(arg0, 1);
        assert_if_pool_owner_not_matched<T0>(arg1, 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(withdraw_from_pool<T0>(arg1, arg2, arg3), arg4), 0x2::tx_context::sender(arg4));
    }

    fun withdraw_from_pool<T0>(arg0: &mut SponsorPool<T0>, arg1: u64, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        assert_if_pool_balance_not_enough<T0>(arg0, arg1);
        if (0x1::option::is_some<SponsorPoolSettings>(&arg0.settings)) {
            let v0 = 0x1::option::borrow_mut<SponsorPoolSettings>(&mut arg0.settings);
            if (0x2::clock::timestamp_ms(arg2) > v0.deadline) {
                v0.remaining = 0x2::balance::value<T0>(&arg0.asset) - arg1;
            } else {
                v0.remaining = v0.remaining - arg1;
            };
        };
        0x2::balance::split<T0>(&mut arg0.asset, arg1)
    }

    // decompiled from Move bytecode v6
}

