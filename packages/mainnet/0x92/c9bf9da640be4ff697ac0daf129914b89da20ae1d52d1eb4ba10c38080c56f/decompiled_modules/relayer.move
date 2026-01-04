module 0x92c9bf9da640be4ff697ac0daf129914b89da20ae1d52d1eb4ba10c38080c56f::relayer {
    struct RelayerInfo has store {
        stake: 0x2::balance::Balance<0x92c9bf9da640be4ff697ac0daf129914b89da20ae1d52d1eb4ba10c38080c56f::cloak_coin::CLOAK_COIN>,
        fee_rate_bps: u64,
        metadata_url: 0x1::string::String,
        registered_at: u64,
        tx_count: u64,
        reputation: u64,
    }

    struct RelayerPool has store, key {
        id: 0x2::object::UID,
        relayers: 0x2::table::Table<address, RelayerInfo>,
    }

    struct RelayEvent has copy, drop {
        relayer: address,
        recipient: address,
        amount: u64,
        fee: u64,
        timestamp: u64,
    }

    public entry fun deregister(arg0: &mut RelayerPool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, RelayerInfo>(&arg0.relayers, v0), 1);
        assert!(0x2::clock::timestamp_ms(arg1) >= 0x2::table::borrow<address, RelayerInfo>(&arg0.relayers, v0).registered_at + 86400000, 5);
        let RelayerInfo {
            stake         : v1,
            fee_rate_bps  : _,
            metadata_url  : _,
            registered_at : _,
            tx_count      : _,
            reputation    : _,
        } = 0x2::table::remove<address, RelayerInfo>(&mut arg0.relayers, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x92c9bf9da640be4ff697ac0daf129914b89da20ae1d52d1eb4ba10c38080c56f::cloak_coin::CLOAK_COIN>>(0x2::coin::from_balance<0x92c9bf9da640be4ff697ac0daf129914b89da20ae1d52d1eb4ba10c38080c56f::cloak_coin::CLOAK_COIN>(v1, arg2), v0);
    }

    public entry fun execute_relay(arg0: &mut RelayerPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: address, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, RelayerInfo>(&arg0.relayers, arg4), 1);
        let v0 = 0x2::table::borrow_mut<address, RelayerInfo>(&mut arg0.relayers, arg4);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(arg2 <= v1 * v0.fee_rate_bps / 10000, 4);
        assert!(v1 >= arg2, 2);
        v0.tx_count = v0.tx_count + 1;
        if (v0.reputation < 1000) {
            v0.reputation = v0.reputation + 1;
        };
        let v2 = RelayEvent{
            relayer   : arg4,
            recipient : arg3,
            amount    : v1 - arg2,
            fee       : arg2,
            timestamp : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<RelayEvent>(v2);
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3, arg2), arg6), arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v3, arg6), arg3);
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

    public entry fun register(arg0: &mut RelayerPool, arg1: 0x2::coin::Coin<0x92c9bf9da640be4ff697ac0daf129914b89da20ae1d52d1eb4ba10c38080c56f::cloak_coin::CLOAK_COIN>, arg2: u64, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x92c9bf9da640be4ff697ac0daf129914b89da20ae1d52d1eb4ba10c38080c56f::cloak_coin::CLOAK_COIN>(&arg1) >= 5000000000000000, 0);
        assert!(arg2 <= 1000, 3);
        let v0 = 0x2::tx_context::sender(arg5);
        if (0x2::table::contains<address, RelayerInfo>(&arg0.relayers, v0)) {
            let v1 = 0x2::table::borrow_mut<address, RelayerInfo>(&mut arg0.relayers, v0);
            0x2::balance::join<0x92c9bf9da640be4ff697ac0daf129914b89da20ae1d52d1eb4ba10c38080c56f::cloak_coin::CLOAK_COIN>(&mut v1.stake, 0x2::coin::into_balance<0x92c9bf9da640be4ff697ac0daf129914b89da20ae1d52d1eb4ba10c38080c56f::cloak_coin::CLOAK_COIN>(arg1));
            v1.fee_rate_bps = arg2;
            v1.metadata_url = 0x1::string::utf8(arg3);
        } else {
            let v2 = RelayerInfo{
                stake         : 0x2::coin::into_balance<0x92c9bf9da640be4ff697ac0daf129914b89da20ae1d52d1eb4ba10c38080c56f::cloak_coin::CLOAK_COIN>(arg1),
                fee_rate_bps  : arg2,
                metadata_url  : 0x1::string::utf8(arg3),
                registered_at : 0x2::clock::timestamp_ms(arg4),
                tx_count      : 0,
                reputation    : 100,
            };
            0x2::table::add<address, RelayerInfo>(&mut arg0.relayers, v0, v2);
        };
    }

    // decompiled from Move bytecode v6
}

