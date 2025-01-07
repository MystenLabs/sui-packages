module 0xd36da552aeffa3328a9379c4e41e3b7fe4dfb6c10bbe8e617fcd52c7a7c121c1::quest {
    struct QuestPass has key {
        id: 0x2::object::UID,
        referrer: address,
        referee: address,
        timestamp_ms: u64,
    }

    struct QuestHouse has key {
        id: 0x2::object::UID,
        claims: 0x2::table::Table<address, bool>,
    }

    struct QUEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUEST, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<QUEST>(arg0, arg1);
        let v0 = QuestHouse{
            id     : 0x2::object::new(arg1),
            claims : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::share_object<QuestHouse>(v0);
    }

    public fun mint(arg0: &mut QuestHouse, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<address, bool>(&arg0.claims, 0x2::tx_context::sender(arg3)), 1);
        assert!(arg1 != 0x2::tx_context::sender(arg3), 2);
        0x2::table::add<address, bool>(&mut arg0.claims, 0x2::tx_context::sender(arg3), true);
        let v0 = QuestPass{
            id           : 0x2::object::new(arg3),
            referrer     : arg1,
            referee      : 0x2::tx_context::sender(arg3),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::transfer::transfer<QuestPass>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

