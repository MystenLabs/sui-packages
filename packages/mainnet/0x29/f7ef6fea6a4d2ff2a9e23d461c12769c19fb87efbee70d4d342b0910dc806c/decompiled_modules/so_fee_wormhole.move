module 0x47989e1f044f37b797ed052aba94874872b5dfd2d0d2afb1278f967d0d895867::so_fee_wormhole {
    struct PriceData has drop, store {
        current_price_ratio: u64,
        last_update_timestamp: u64,
    }

    struct PriceManager has key {
        id: 0x2::object::UID,
        price_data: 0x2::table::Table<u16, PriceData>,
        owner: address,
    }

    public fun get_price_ratio(arg0: &mut PriceManager, arg1: u16) : u64 {
        if (0x2::table::contains<u16, PriceData>(&arg0.price_data, arg1)) {
            0x2::table::borrow<u16, PriceData>(&arg0.price_data, arg1).current_price_ratio
        } else {
            0
        }
    }

    public fun get_timestamp(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceManager{
            id         : 0x2::object::new(arg0),
            price_data : 0x2::table::new<u16, PriceData>(arg0),
            owner      : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<PriceManager>(v0);
    }

    public entry fun set_price_ratio(arg0: &0x2::clock::Clock, arg1: &mut PriceManager, arg2: u16, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg4), 4);
        if (!0x2::table::contains<u16, PriceData>(&arg1.price_data, arg2)) {
            let v0 = PriceData{
                current_price_ratio   : arg3,
                last_update_timestamp : get_timestamp(arg0),
            };
            0x2::table::add<u16, PriceData>(&mut arg1.price_data, arg2, v0);
        } else {
            let v1 = 0x2::table::borrow_mut<u16, PriceData>(&mut arg1.price_data, arg2);
            v1.current_price_ratio = arg3;
            v1.last_update_timestamp = get_timestamp(arg0);
        };
    }

    public entry fun transfer_owner(arg0: &mut PriceManager, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 4);
        arg0.owner = arg1;
    }

    // decompiled from Move bytecode v6
}

