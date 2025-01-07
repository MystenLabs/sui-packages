module 0x190064c902107ab576fd0e4b828c71c7928fae150c4da9a52b9aa241313c60d1::luckydraw {
    struct LuckyDrawCreatedEvent has copy, drop {
        community_id: address,
        type: 0x1::string::String,
        lucky_draw_id: 0x2::object::ID,
    }

    struct DrawCreatedEvent has copy, drop {
        lucky_draw_id: 0x2::object::ID,
        community_id: address,
        list_winner: vector<address>,
    }

    struct LuckyDraw has store, key {
        id: 0x2::object::UID,
        community_id: address,
        type: 0x1::string::String,
        list_address: vector<address>,
        list_winners: vector<address>,
        create_date: u64,
        owner: address,
    }

    public entry fun add_draw(arg0: address, arg1: vector<u8>, arg2: u64, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = LuckyDraw{
            id           : 0x2::object::new(arg4),
            community_id : arg0,
            type         : 0x1::string::utf8(arg1),
            list_address : 0x1::vector::empty<address>(),
            list_winners : 0x1::vector::empty<address>(),
            create_date  : arg2,
            owner        : 0x2::tx_context::sender(arg4),
        };
        let v1 = LuckyDrawCreatedEvent{
            community_id  : arg0,
            type          : 0x1::string::utf8(arg1),
            lucky_draw_id : 0x2::object::id<LuckyDraw>(&v0),
        };
        0x2::event::emit<LuckyDrawCreatedEvent>(v1);
        while (!0x1::vector::is_empty<address>(&arg3)) {
            0x1::vector::push_back<address>(&mut v0.list_address, 0x1::vector::pop_back<address>(&mut arg3));
        };
        0x2::transfer::share_object<LuckyDraw>(v0);
    }

    public fun draw(arg0: &mut LuckyDraw, arg1: u8, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 0);
        let v0 = 0;
        let v1 = arg0.list_address;
        loop {
            v0 = v0 + 1;
            0x1::vector::push_back<address>(&mut arg0.list_winners, 0x1::vector::remove<address>(&mut v1, 0x2::clock::timestamp_ms(arg2) % 0x1::vector::length<address>(&v1)));
            if (v0 >= arg1) {
                break
            };
        };
        let v2 = DrawCreatedEvent{
            lucky_draw_id : 0x2::object::uid_to_inner(&arg0.id),
            community_id  : arg0.community_id,
            list_winner   : arg0.list_winners,
        };
        0x2::event::emit<DrawCreatedEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

