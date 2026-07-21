module 0x621ec2c7c2d24afff19cc14bc29c0f61722f99dd1b0d50de92ca47d790ec2b3a::card_registry {
    struct CardData has copy, drop, store {
        blob_id: 0x1::string::String,
        updated_at: u64,
        updated_by: address,
    }

    struct CardRegistry has key {
        id: 0x2::object::UID,
        cards: 0x2::table::Table<0x2::object::ID, CardData>,
    }

    struct CardSet has copy, drop {
        name_cap_id: 0x2::object::ID,
        blob_id: 0x1::string::String,
        owner: address,
    }

    public fun get_card(arg0: &CardRegistry, arg1: 0x2::object::ID) : (0x1::string::String, u64, address) {
        let v0 = 0x2::table::borrow<0x2::object::ID, CardData>(&arg0.cards, arg1);
        (v0.blob_id, v0.updated_at, v0.updated_by)
    }

    public fun has_card(arg0: &CardRegistry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, CardData>(&arg0.cards, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CardRegistry{
            id    : 0x2::object::new(arg0),
            cards : 0x2::table::new<0x2::object::ID, CardData>(arg0),
        };
        0x2::transfer::share_object<CardRegistry>(v0);
    }

    public fun set_card(arg0: &mut CardRegistry, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg2) > 0, 0);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = CardData{
            blob_id    : arg2,
            updated_at : 0x2::clock::timestamp_ms(arg3),
            updated_by : v0,
        };
        if (0x2::table::contains<0x2::object::ID, CardData>(&arg0.cards, arg1)) {
            *0x2::table::borrow_mut<0x2::object::ID, CardData>(&mut arg0.cards, arg1) = v1;
        } else {
            0x2::table::add<0x2::object::ID, CardData>(&mut arg0.cards, arg1, v1);
        };
        let v2 = CardSet{
            name_cap_id : arg1,
            blob_id     : v1.blob_id,
            owner       : v0,
        };
        0x2::event::emit<CardSet>(v2);
    }

    // decompiled from Move bytecode v6
}

