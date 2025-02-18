module 0xee06526a5a70de13a83df96280d3c87d8bf84fbe915c746008309b790e0befe9::hasui_yield {
    struct HasuiYieldObject has store, key {
        id: 0x2::object::UID,
        total_asset: u64,
        exchange_rate: u64,
    }

    public(friend) fun delete(arg0: HasuiYieldObject) {
        let HasuiYieldObject {
            id            : v0,
            total_asset   : _,
            exchange_rate : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun get_exchange_rate(arg0: &HasuiYieldObject) : u64 {
        arg0.exchange_rate
    }

    public fun get_total_asset(arg0: &HasuiYieldObject) : u64 {
        arg0.total_asset
    }

    public fun merge(arg0: &mut HasuiYieldObject, arg1: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: HasuiYieldObject, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.exchange_rate == arg2.exchange_rate, 0);
        arg0.total_asset = arg0.total_asset + arg2.total_asset;
        delete(arg2);
    }

    public(friend) fun mint(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : HasuiYieldObject {
        HasuiYieldObject{
            id            : 0x2::object::new(arg2),
            total_asset   : arg0,
            exchange_rate : arg1,
        }
    }

    public fun split(arg0: &mut HasuiYieldObject, arg1: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : HasuiYieldObject {
        let v0 = HasuiYieldObject{
            id            : 0x2::object::new(arg3),
            total_asset   : arg2,
            exchange_rate : arg0.exchange_rate,
        };
        arg0.total_asset = arg0.total_asset - arg2;
        v0
    }

    // decompiled from Move bytecode v6
}

