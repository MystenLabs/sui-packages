module 0x94aa81f698b147fe2dc85c33efe788d7d1dcec85d9b7d5d95598bd969036833f::fee_router {
    struct VoltRouterConfig has key {
        id: 0x2::object::UID,
        fee_bps: u64,
        buyback_ratio_bps: u64,
        treasury_address: address,
        buyback_vault_address: address,
        is_paused: bool,
    }

    struct RouterAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeCollectedEvent has copy, drop {
        total_fee: u64,
        to_treasury: u64,
        to_buyback: u64,
    }

    struct ConfigUpdatedEvent has copy, drop {
        new_fee_bps: u64,
        new_buyback_ratio_bps: u64,
        new_treasury: address,
        new_buyback_vault: address,
        is_paused: bool,
    }

    public fun extract_fee<T0>(arg0: &VoltRouterConfig, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x1::option::Option<0x2::coin::Coin<T0>>) {
        if (arg0.is_paused || arg0.fee_bps == 0) {
            return (arg1, 0x1::option::none<0x2::coin::Coin<T0>>())
        };
        let v0 = 0x2::coin::value<T0>(&arg1) * arg0.fee_bps / 10000;
        if (v0 == 0) {
            return (arg1, 0x1::option::none<0x2::coin::Coin<T0>>())
        };
        (arg1, 0x1::option::some<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v0, arg2)))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = VoltRouterConfig{
            id                    : 0x2::object::new(arg0),
            fee_bps               : 15,
            buyback_ratio_bps     : 5000,
            treasury_address      : v0,
            buyback_vault_address : v0,
            is_paused             : false,
        };
        0x2::transfer::share_object<VoltRouterConfig>(v1);
        let v2 = RouterAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<RouterAdminCap>(v2, v0);
    }

    public fun route_fee<T0>(arg0: &VoltRouterConfig, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = v0 * arg0.buyback_ratio_bps / 10000;
        let v2 = v0 - v1;
        if (v1 > 0 && v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v1, arg2), arg0.buyback_vault_address);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.treasury_address);
        } else if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.buyback_vault_address);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.treasury_address);
        };
        let v3 = FeeCollectedEvent{
            total_fee   : v0,
            to_treasury : v2,
            to_buyback  : v1,
        };
        0x2::event::emit<FeeCollectedEvent>(v3);
    }

    public fun update_config(arg0: &RouterAdminCap, arg1: &mut VoltRouterConfig, arg2: u64, arg3: u64, arg4: address, arg5: address, arg6: bool) {
        assert!(arg2 <= 100, 1);
        assert!(arg3 <= 10000, 1);
        arg1.fee_bps = arg2;
        arg1.buyback_ratio_bps = arg3;
        arg1.treasury_address = arg4;
        arg1.buyback_vault_address = arg5;
        arg1.is_paused = arg6;
        let v0 = ConfigUpdatedEvent{
            new_fee_bps           : arg2,
            new_buyback_ratio_bps : arg3,
            new_treasury          : arg4,
            new_buyback_vault     : arg5,
            is_paused             : arg6,
        };
        0x2::event::emit<ConfigUpdatedEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

