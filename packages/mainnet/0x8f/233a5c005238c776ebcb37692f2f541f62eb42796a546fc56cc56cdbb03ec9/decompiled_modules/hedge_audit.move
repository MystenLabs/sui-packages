module 0x8f233a5c005238c776ebcb37692f2f541f62eb42796a546fc56cc56cdbb03ec9::hedge_audit {
    struct Registry has key {
        id: 0x2::object::UID,
        emergencies: vector<0x1::string::String>,
    }

    struct HedgeOpenedProtected has copy, drop {
        agent: 0x1::string::String,
        event: 0x1::string::String,
        emergency_id: 0x1::string::String,
        hl_account: 0x1::string::String,
        hl_order_id: u64,
        hl_link: 0x1::string::String,
        recorded_at_ms: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x88164b403ff0e7eea21d4c5d7313c75d8ec32df42ddc661900992fc10202c60, 1);
        0x2::transfer::transfer<Registry>(new_registry(arg0), @0x88164b403ff0e7eea21d4c5d7313c75d8ec32df42ddc661900992fc10202c60);
    }

    fun new_registry(arg0: &mut 0x2::tx_context::TxContext) : Registry {
        Registry{
            id          : 0x2::object::new(arg0),
            emergencies : 0x1::vector::empty<0x1::string::String>(),
        }
    }

    public fun record(arg0: &mut Registry, arg1: 0x1::string::String, arg2: u64, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == @0x88164b403ff0e7eea21d4c5d7313c75d8ec32df42ddc661900992fc10202c60, 1);
        assert!(0x1::string::length(&arg1) > 0 && 0x1::string::length(&arg1) <= 128, 3);
        let v0 = if (arg2 > 0) {
            if (0x1::string::length(&arg3) > 0) {
                0x1::string::length(&arg3) <= 256
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 3);
        assert!(!0x1::vector::contains<0x1::string::String>(&arg0.emergencies, &arg1), 2);
        0x1::vector::push_back<0x1::string::String>(&mut arg0.emergencies, arg1);
        let v1 = HedgeOpenedProtected{
            agent          : 0x1::string::utf8(b"algorido-p7-emergency-hedge"),
            event          : 0x1::string::utf8(b"HEDGE_OPENED_PROTECTED"),
            emergency_id   : arg1,
            hl_account     : 0x1::string::utf8(b"0x983df2a41c7c4af0bb1ff5afee8d060fc4d7de7e"),
            hl_order_id    : arg2,
            hl_link        : arg3,
            recorded_at_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<HedgeOpenedProtected>(v1);
    }

    // decompiled from Move bytecode v6
}

