module 0x791441ea7d717ed19d75b8edfc0f13256108cae4016c21e6dbf23e5d728a99dc::social_bottle {
    struct DriftBottle has store, key {
        id: 0x2::object::UID,
        from: address,
        from_time: u64,
        open: bool,
        to: 0x1::option::Option<address>,
        reply_time: u64,
        msgs: vector<BlobInfo>,
    }

    struct BlobInfo has copy, drop, store {
        blob_id: 0x1::string::String,
        blob_obj: address,
    }

    struct BottleEvent has copy, drop {
        from: address,
        to: 0x1::option::Option<address>,
        bottle_id: 0x2::object::ID,
        action_type: 0x1::string::String,
    }

    public fun createBlobInfos(arg0: vector<0x1::string::String>, arg1: vector<address>) : vector<BlobInfo> {
        let v0 = 0x1::vector::empty<BlobInfo>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg0)) {
            let v2 = BlobInfo{
                blob_id  : *0x1::vector::borrow<0x1::string::String>(&arg0, v1),
                blob_obj : *0x1::vector::borrow<address>(&arg1, v1),
            };
            0x1::vector::insert<BlobInfo>(&mut v0, v2, v1);
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun createBottle(arg0: vector<0x1::string::String>, arg1: vector<address>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::is_empty<0x1::string::String>(&arg0), 0);
        assert!(0x1::vector::length<0x1::string::String>(&arg0) == 0x1::vector::length<address>(&arg1), 1);
        let v0 = DriftBottle{
            id         : 0x2::object::new(arg3),
            from       : 0x2::tx_context::sender(arg3),
            from_time  : 0x2::clock::timestamp_ms(arg2) / 1000,
            open       : false,
            to         : 0x1::option::none<address>(),
            reply_time : 0,
            msgs       : createBlobInfos(arg0, arg1),
        };
        let v1 = BottleEvent{
            from        : 0x2::tx_context::sender(arg3),
            to          : 0x1::option::none<address>(),
            bottle_id   : 0x2::object::uid_to_inner(&v0.id),
            action_type : 0x1::string::utf8(b"create"),
        };
        0x2::event::emit<BottleEvent>(v1);
        0x2::transfer::share_object<DriftBottle>(v0);
    }

    public entry fun openAndReplyBottle(arg0: &mut DriftBottle, arg1: vector<0x1::string::String>, arg2: vector<address>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::is_empty<0x1::string::String>(&arg1), 0);
        assert!(0x1::vector::length<0x1::string::String>(&arg1) == 0x1::vector::length<address>(&arg2), 1);
        let v0 = arg0.msgs;
        assert!(0x1::vector::length<BlobInfo>(&v0) >= 1, 2);
        assert!(!arg0.open, 3);
        0x1::vector::append<BlobInfo>(&mut v0, createBlobInfos(arg1, arg2));
        arg0.msgs = v0;
        arg0.open = true;
        arg0.to = 0x1::option::some<address>(0x2::tx_context::sender(arg4));
        arg0.reply_time = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v1 = BottleEvent{
            from        : arg0.from,
            to          : 0x1::option::some<address>(0x2::tx_context::sender(arg4)),
            bottle_id   : 0x2::object::uid_to_inner(&arg0.id),
            action_type : 0x1::string::utf8(b"reply"),
        };
        0x2::event::emit<BottleEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

