module 0x5d4453a3dd7ea1196171b4ee99347a6c7f92cb7608c1dfd03c49e931b6d0ba0f::fee_splitter {
    struct FeeConfig has key {
        id: 0x2::object::UID,
        admin: address,
        buyback_addr: address,
        ve_addr: address,
        treasury_addr: address,
        buyback_bps: u64,
        ve_bps: u64,
        treasury_bps: u64,
    }

    struct FeeSplit has copy, drop {
        coin_type: 0x1::ascii::String,
        total: u64,
        buyback: u64,
        ve: u64,
        treasury: u64,
    }

    struct ConfigUpdated has copy, drop {
        admin: address,
    }

    public fun split<T0>(arg0: &FeeConfig, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::into_balance<T0>(arg1);
        let v2 = (((v0 as u128) * (arg0.buyback_bps as u128) / (10000 as u128)) as u64);
        let v3 = (((v0 as u128) * (arg0.ve_bps as u128) / (10000 as u128)) as u64);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1, v2), arg2), arg0.buyback_addr);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1, v3), arg2), arg0.ve_addr);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg2), arg0.treasury_addr);
        let v4 = FeeSplit{
            coin_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            total     : v0,
            buyback   : v2,
            ve        : v3,
            treasury  : 0x2::balance::value<T0>(&v1),
        };
        0x2::event::emit<FeeSplit>(v4);
    }

    fun new(arg0: address, arg1: address, arg2: address, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : FeeConfig {
        assert!(arg4 + arg5 + arg6 == 10000, 1);
        FeeConfig{
            id            : 0x2::object::new(arg7),
            admin         : arg0,
            buyback_addr  : arg1,
            ve_addr       : arg2,
            treasury_addr : arg3,
            buyback_bps   : arg4,
            ve_bps        : arg5,
            treasury_bps  : arg6,
        }
    }

    public fun admin(arg0: &FeeConfig) : address {
        arg0.admin
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        0x2::transfer::share_object<FeeConfig>(new(v0, v0, v0, v0, 4000, 4000, 2000, arg0));
    }

    public fun set_addresses(arg0: &mut FeeConfig, arg1: address, arg2: address, arg3: address, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0);
        arg0.buyback_addr = arg1;
        arg0.ve_addr = arg2;
        arg0.treasury_addr = arg3;
        let v0 = ConfigUpdated{admin: arg0.admin};
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public fun set_admin(arg0: &mut FeeConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.admin = arg1;
    }

    public fun set_split(arg0: &mut FeeConfig, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0);
        assert!(arg1 + arg2 + arg3 == 10000, 1);
        arg0.buyback_bps = arg1;
        arg0.ve_bps = arg2;
        arg0.treasury_bps = arg3;
        let v0 = ConfigUpdated{admin: arg0.admin};
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public fun split_bps(arg0: &FeeConfig) : (u64, u64, u64) {
        (arg0.buyback_bps, arg0.ve_bps, arg0.treasury_bps)
    }

    // decompiled from Move bytecode v7
}

