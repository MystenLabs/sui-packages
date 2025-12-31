module 0x30744f46827de2c15de4a2b1d972cb86f9cfef31eb49a52ef3086df5f775e35::relayer {
    struct RelayerInfo has store {
        stake: 0x2::balance::Balance<0x30744f46827de2c15de4a2b1d972cb86f9cfef31eb49a52ef3086df5f775e35::cloak_coin::CLOAK_COIN>,
        fee_rate_bps: u64,
        registered_at: u64,
        tx_count: u64,
        reputation: u64,
    }

    struct RelayerPool has store, key {
        id: 0x2::object::UID,
        relayers: 0x2::table::Table<address, RelayerInfo>,
    }

    public entry fun deregister(arg0: &mut RelayerPool, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, RelayerInfo>(&arg0.relayers, v0), 1);
        let RelayerInfo {
            stake         : v1,
            fee_rate_bps  : _,
            registered_at : _,
            tx_count      : _,
            reputation    : _,
        } = 0x2::table::remove<address, RelayerInfo>(&mut arg0.relayers, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x30744f46827de2c15de4a2b1d972cb86f9cfef31eb49a52ef3086df5f775e35::cloak_coin::CLOAK_COIN>>(0x2::coin::from_balance<0x30744f46827de2c15de4a2b1d972cb86f9cfef31eb49a52ef3086df5f775e35::cloak_coin::CLOAK_COIN>(v1, arg1), v0);
    }

    public entry fun execute_relay(arg0: &mut RelayerPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: address, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, RelayerInfo>(&arg0.relayers, arg4), 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg2, 2);
        let v0 = 0x2::table::borrow_mut<address, RelayerInfo>(&mut arg0.relayers, arg4);
        v0.tx_count = v0.tx_count + 1;
        if (v0.reputation < 1000) {
            v0.reputation = v0.reputation + 1;
        };
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1, arg2), arg5), arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg5), arg3);
    }

    public fun get_fee_rate(arg0: &RelayerPool, arg1: address) : u64 {
        0x2::table::borrow<address, RelayerInfo>(&arg0.relayers, arg1).fee_rate_bps
    }

    public fun get_reputation(arg0: &RelayerPool, arg1: address) : u64 {
        0x2::table::borrow<address, RelayerInfo>(&arg0.relayers, arg1).reputation
    }

    public fun get_tx_count(arg0: &RelayerPool, arg1: address) : u64 {
        0x2::table::borrow<address, RelayerInfo>(&arg0.relayers, arg1).tx_count
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RelayerPool{
            id       : 0x2::object::new(arg0),
            relayers : 0x2::table::new<address, RelayerInfo>(arg0),
        };
        0x2::transfer::share_object<RelayerPool>(v0);
    }

    public fun is_relayer(arg0: &RelayerPool, arg1: address) : bool {
        0x2::table::contains<address, RelayerInfo>(&arg0.relayers, arg1)
    }

    public entry fun register(arg0: &mut RelayerPool, arg1: 0x2::coin::Coin<0x30744f46827de2c15de4a2b1d972cb86f9cfef31eb49a52ef3086df5f775e35::cloak_coin::CLOAK_COIN>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x30744f46827de2c15de4a2b1d972cb86f9cfef31eb49a52ef3086df5f775e35::cloak_coin::CLOAK_COIN>(&arg1) >= 5000000000000000, 0);
        assert!(arg2 <= 1000, 3);
        let v0 = 0x2::tx_context::sender(arg4);
        if (0x2::table::contains<address, RelayerInfo>(&arg0.relayers, v0)) {
            let v1 = 0x2::table::borrow_mut<address, RelayerInfo>(&mut arg0.relayers, v0);
            0x2::balance::join<0x30744f46827de2c15de4a2b1d972cb86f9cfef31eb49a52ef3086df5f775e35::cloak_coin::CLOAK_COIN>(&mut v1.stake, 0x2::coin::into_balance<0x30744f46827de2c15de4a2b1d972cb86f9cfef31eb49a52ef3086df5f775e35::cloak_coin::CLOAK_COIN>(arg1));
            v1.fee_rate_bps = arg2;
        } else {
            let v2 = RelayerInfo{
                stake         : 0x2::coin::into_balance<0x30744f46827de2c15de4a2b1d972cb86f9cfef31eb49a52ef3086df5f775e35::cloak_coin::CLOAK_COIN>(arg1),
                fee_rate_bps  : arg2,
                registered_at : 0x2::clock::timestamp_ms(arg3),
                tx_count      : 0,
                reputation    : 100,
            };
            0x2::table::add<address, RelayerInfo>(&mut arg0.relayers, v0, v2);
        };
    }

    // decompiled from Move bytecode v6
}

