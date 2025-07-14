module 0xa6a5401410d90b43f979b381f1c3e4f423f82f03ae78e498a8f67afa90a16718::loria_deck {
    struct LoriaDeck has key {
        id: 0x2::object::UID,
        owner: address,
        blob_id: 0x1::string::String,
        cards: vector<0x2::object::ID>,
    }

    public(friend) fun new(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = LoriaDeck{
            id      : 0x2::object::new(arg1),
            owner   : 0x2::tx_context::sender(arg1),
            blob_id : arg0,
            cards   : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::transfer<LoriaDeck>(v0, 0x2::tx_context::sender(arg1));
        0x2::object::id<LoriaDeck>(&v0)
    }

    public(friend) fun add_card(arg0: &mut LoriaDeck, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.cards, arg1);
    }

    public fun contains_card(arg0: &LoriaDeck, arg1: 0x2::object::ID) : bool {
        0x1::vector::contains<0x2::object::ID>(&arg0.cards, &arg1)
    }

    public fun get_cards(arg0: &LoriaDeck) : vector<0x2::object::ID> {
        arg0.cards
    }

    public fun get_id(arg0: &LoriaDeck) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_owner(arg0: &LoriaDeck) : address {
        arg0.owner
    }

    public(friend) fun remove_card(arg0: &mut LoriaDeck, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        let v0 = &arg0.cards;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x2::object::ID>(v0)) {
            if (0x1::vector::borrow<0x2::object::ID>(v0, v1) == &arg1) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 8 */
                if (0x1::option::is_some<u64>(&v2)) {
                    0x1::vector::remove<0x2::object::ID>(&mut arg0.cards, *0x1::option::borrow<u64>(&v2));
                };
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 8 */
    }

    public(friend) fun remove_deck(arg0: LoriaDeck, arg1: &mut 0x2::tx_context::TxContext) {
        let LoriaDeck {
            id      : v0,
            owner   : _,
            blob_id : _,
            cards   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

