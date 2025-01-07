module 0x63f930881f4207460a67846db62bc89a82d87570a3dc2bedb546b30bd4c6ff19::oracle {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Root has key {
        id: 0x2::object::UID,
        total: u64,
    }

    struct PriceFeed has store, key {
        id: 0x2::object::UID,
        symbol: 0x1::string::String,
        price: u64,
        owner: address,
        timestamp: u64,
    }

    public entry fun create_price_feed(arg0: &mut AdminCap, arg1: &mut Root, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = new_price_feed(arg2, arg3);
        0x2::dynamic_object_field::add<0x2::object::ID, PriceFeed>(&mut arg1.id, 0x2::object::uid_to_inner(&v0.id), v0);
    }

    public fun get_price(arg0: &Root, arg1: 0x2::object::ID) : (u64, u64) {
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 5);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, PriceFeed>(&arg0.id, arg1);
        (v0.price, v0.timestamp)
    }

    public fun get_uid(arg0: &Root) : &0x2::object::UID {
        &arg0.id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Root{
            id    : 0x2::object::new(arg0),
            total : 0,
        };
        0x2::transfer::share_object<Root>(v1);
    }

    fun new_price_feed(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : PriceFeed {
        assert!(!0x1::vector::is_empty<u8>(&arg0), 1);
        assert!(0x1::vector::length<u8>(&arg0) < 20, 2);
        PriceFeed{
            id        : 0x2::object::new(arg1),
            symbol    : 0x1::string::utf8(arg0),
            price     : 0,
            owner     : 0x2::tx_context::sender(arg1),
            timestamp : 0,
        }
    }

    public entry fun update_owner(arg0: &mut AdminCap, arg1: &mut Root, arg2: 0x2::object::ID, arg3: address, arg4: &0x2::tx_context::TxContext) {
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, PriceFeed>(&mut arg1.id, arg2).owner = arg3;
    }

    public entry fun update_price(arg0: &mut Root, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, PriceFeed>(&mut arg0.id, arg1);
        assert!(arg3 > v0.timestamp, 3);
        assert!(0x2::tx_context::sender(arg4) == v0.owner, 4);
        v0.price = arg2;
        v0.timestamp = arg3;
    }

    // decompiled from Move bytecode v6
}

