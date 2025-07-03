module 0x246d19f0e524457cf65424ce40b79b139298cea2f935db2ce28e2b1045f0f4f::issuer {
    struct EventConfig has store, key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
        creator: address,
        manager_whitelist: 0x2::vec_set::VecSet<address>,
    }

    struct Event has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        img_url: 0x1::string::String,
        poap_name: 0x1::string::String,
        poap_description: 0x1::string::String,
        poap_img_path: 0x1::string::String,
        expired_at: u64,
        visitors: vector<address>,
    }

    public fun add_manager_to_whitelist(arg0: &mut EventConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 1005);
        assert!(!0x2::vec_set::contains<address>(&arg0.manager_whitelist, &arg1), 1003);
        0x2::vec_set::insert<address>(&mut arg0.manager_whitelist, arg1);
    }

    public fun create_event(arg0: &mut EventConfig, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(v0 == arg0.creator || is_manager_authorized(arg0, v0), 1002);
        let v1 = 0x1::string::utf8(b"https://assets.suipo.app/");
        0x1::string::append(&mut v1, arg4);
        let v2 = Event{
            id               : 0x2::object::new(arg9),
            name             : arg2,
            description      : arg3,
            img_url          : v1,
            poap_name        : arg5,
            poap_description : arg6,
            poap_img_path    : arg7,
            expired_at       : arg8,
            visitors         : 0x1::vector::empty<address>(),
        };
        0x2::dynamic_object_field::add<0x1::string::String, Event>(&mut arg0.id, arg1, v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = EventConfig{
            id                : 0x2::object::new(arg0),
            description       : 0x1::string::utf8(b"Developers Event"),
            creator           : 0x2::tx_context::sender(arg0),
            manager_whitelist : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<EventConfig>(v0);
    }

    public fun is_manager_authorized(arg0: &EventConfig, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.manager_whitelist, &arg1)
    }

    public fun mint(arg0: &mut EventConfig, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, Event>(&mut arg0.id, arg2);
        assert!(0x2::clock::timestamp_ms(arg1) < v0.expired_at, 1001);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(!0x1::vector::contains<address>(&v0.visitors, &v1), 1006);
        0x1::vector::push_back<address>(&mut v0.visitors, v1);
        0x2::transfer::public_transfer<0x246d19f0e524457cf65424ce40b79b139298cea2f935db2ce28e2b1045f0f4f::nft::PoapNFT>(0x246d19f0e524457cf65424ce40b79b139298cea2f935db2ce28e2b1045f0f4f::nft::new(v0.poap_name, arg2, v0.poap_description, v0.poap_img_path, arg1, arg3), v1);
    }

    public fun remove_manager_from_whitelist(arg0: &mut EventConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 1005);
        assert!(0x2::vec_set::contains<address>(&arg0.manager_whitelist, &arg1), 1004);
        0x2::vec_set::remove<address>(&mut arg0.manager_whitelist, &arg1);
    }

    // decompiled from Move bytecode v6
}

