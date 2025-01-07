module 0xd6d4204bce005a0f36aec052e10d0c937d4b8cd970d4817b5a9deae282298cb2::external_launchpad {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Whitelist has store {
        inner: 0x2::table::Table<address, u64>,
    }

    struct Launchpad has store, key {
        id: 0x2::object::UID,
        claimable: bool,
        refundable_started_at_ms: u64,
        refundable_ended_at_ms: u64,
        xflx_ratio: u64,
        whitelists: vector<Whitelist>,
        balance: 0x2::balance::Balance<0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::flx::FLX>,
        treasury: address,
    }

    struct Refund has copy, drop {
        sender: address,
    }

    struct Claim has copy, drop {
        sender: address,
    }

    public fun available(arg0: &Whitelist, arg1: address) : u64 {
        *0x2::table::borrow<address, u64>(&arg0.inner, arg1)
    }

    public entry fun claim(arg0: &mut Launchpad, arg1: u64, arg2: &mut 0x8d852e2c514b8a661445556e279dd78ba19f042a27b951df6a855850597727e6::xflx::TreasuryManagement, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.claimable, 8);
        perform(arg0, arg1, false, arg2, arg3);
    }

    public entry fun deposit_as_admin(arg0: &AdminCap, arg1: &mut Launchpad, arg2: 0x2::coin::Coin<0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::flx::FLX>) {
        0x2::balance::join<0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::flx::FLX>(&mut arg1.balance, 0x2::coin::into_balance<0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::flx::FLX>(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun initialize(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0x2::clock::timestamp_ms(arg5) && arg2 > arg1, 7);
        let v0 = 0x1::vector::empty<Whitelist>();
        let v1 = Whitelist{inner: 0x2::table::new<address, u64>(arg6)};
        0x1::vector::push_back<Whitelist>(&mut v0, v1);
        let v2 = Whitelist{inner: 0x2::table::new<address, u64>(arg6)};
        0x1::vector::push_back<Whitelist>(&mut v0, v2);
        let v3 = Whitelist{inner: 0x2::table::new<address, u64>(arg6)};
        0x1::vector::push_back<Whitelist>(&mut v0, v3);
        let v4 = Launchpad{
            id                       : 0x2::object::new(arg6),
            claimable                : false,
            refundable_started_at_ms : arg1,
            refundable_ended_at_ms   : arg2,
            xflx_ratio               : arg3,
            whitelists               : v0,
            balance                  : 0x2::balance::zero<0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::flx::FLX>(),
            treasury                 : arg4,
        };
        0x2::transfer::share_object<Launchpad>(v4);
    }

    public fun is_whitelisted(arg0: &Whitelist, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.inner, arg1)
    }

    fun perform(arg0: &mut Launchpad, arg1: u64, arg2: bool, arg3: &mut 0x8d852e2c514b8a661445556e279dd78ba19f042a27b951df6a855850597727e6::xflx::TreasuryManagement, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1::vector::borrow_mut<Whitelist>(&mut arg0.whitelists, arg1);
        assert!(is_whitelisted(v1, v0), 5);
        assert!(available(v1, v0) > 0, 6);
        assert!(0x2::balance::value<0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::flx::FLX>(&arg0.balance) >= available(v1, v0), 3);
        let v2 = 0x2::table::borrow_mut<address, u64>(&mut v1.inner, v0);
        let v3 = 0x2::balance::split<0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::flx::FLX>(&mut arg0.balance, *v2);
        *v2 = 0;
        if (arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::flx::FLX>>(0x2::coin::from_balance<0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::flx::FLX>(v3, arg4), arg0.treasury);
            let v4 = Refund{sender: v0};
            0x2::event::emit<Refund>(v4);
        } else {
            0x8d852e2c514b8a661445556e279dd78ba19f042a27b951df6a855850597727e6::xflx::mint_and_transfer(arg3, 0x2::coin::from_balance<0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::flx::FLX>(0x2::balance::split<0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::flx::FLX>(&mut v3, 0xd6d4204bce005a0f36aec052e10d0c937d4b8cd970d4817b5a9deae282298cb2::u64::mul_div(0x2::balance::value<0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::flx::FLX>(&v3), arg0.xflx_ratio, 10000)), arg4), v0, arg4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::flx::FLX>>(0x2::coin::from_balance<0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::flx::FLX>(v3, arg4), v0);
            let v5 = Claim{sender: v0};
            0x2::event::emit<Claim>(v5);
        };
    }

    public entry fun refund(arg0: &mut Launchpad, arg1: u64, arg2: &mut 0x8d852e2c514b8a661445556e279dd78ba19f042a27b951df6a855850597727e6::xflx::TreasuryManagement, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.refundable_started_at_ms, 1);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.refundable_ended_at_ms, 2);
        perform(arg0, arg1, true, arg2, arg4);
    }

    public entry fun remove_whitelist(arg0: &AdminCap, arg1: &mut Launchpad, arg2: u64, arg3: vector<address>) {
        let v0 = 0;
        let v1 = 0x1::vector::borrow_mut<Whitelist>(&mut arg1.whitelists, arg2);
        while (v0 < 0x1::vector::length<address>(&arg3)) {
            let v2 = *0x1::vector::borrow<address>(&arg3, v0);
            assert!(is_whitelisted(v1, v2), 5);
            0x2::table::remove<address, u64>(&mut v1.inner, v2);
            v0 = v0 + 1;
        };
    }

    public entry fun set_claimable(arg0: &AdminCap, arg1: &mut Launchpad, arg2: bool) {
        arg1.claimable = arg2;
    }

    public entry fun set_whitelist(arg0: &AdminCap, arg1: &mut Launchpad, arg2: u64, arg3: vector<address>, arg4: vector<u64>) {
        assert!(0x1::vector::length<address>(&arg3) == 0x1::vector::length<u64>(&arg4), 0);
        let v0 = 0;
        let v1 = 0x1::vector::borrow_mut<Whitelist>(&mut arg1.whitelists, arg2);
        while (v0 < 0x1::vector::length<address>(&arg3)) {
            let v2 = *0x1::vector::borrow<address>(&arg3, v0);
            assert!(!is_whitelisted(v1, v2), 4);
            0x2::table::add<address, u64>(&mut v1.inner, v2, *0x1::vector::borrow<u64>(&arg4, v0));
            v0 = v0 + 1;
        };
    }

    public entry fun withdraw_as_admin(arg0: &AdminCap, arg1: &mut Launchpad, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::flx::FLX>(&arg1.balance) >= arg2, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::flx::FLX>>(0x2::coin::from_balance<0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::flx::FLX>(0x2::balance::split<0xdb3034eb52a5da620f4752604a6f54879562e547e554b34d26e2144ed9ab3246::flx::FLX>(&mut arg1.balance, arg2), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

