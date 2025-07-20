module 0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::card_pack {
    struct CARD_PACK has drop {
        dummy_field: bool,
    }

    struct Pack has store, key {
        id: 0x2::object::UID,
        pack_id: 0x1::string::String,
        card_pack_template_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        url: 0x1::string::String,
        obtained_at: u64,
        metadata: 0x1::string::String,
        open_until: u64,
    }

    public(friend) fun description(arg0: &Pack) : 0x1::string::String {
        arg0.description
    }

    public(friend) fun get_pack_id(arg0: &Pack) : 0x1::string::String {
        arg0.pack_id
    }

    public(friend) fun image_url(arg0: &Pack) : 0x1::string::String {
        arg0.image_url
    }

    fun init(arg0: CARD_PACK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CARD_PACK>(arg0, arg1);
        let v1 = 0x2::display::new<Pack>(&v0, arg1);
        0x2::display::add<Pack>(&mut v1, 0x1::string::utf8(b"pack_id"), 0x1::string::utf8(b"{pack_id}"));
        0x2::display::add<Pack>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Pack>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Pack>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Pack>(&mut v1, 0x1::string::utf8(b"url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<Pack>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://www.projectj-tcg.com"));
        0x2::display::add<Pack>(&mut v1, 0x1::string::utf8(b"metadata"), 0x1::string::utf8(b"{metadata}"));
        0x2::display::update_version<Pack>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Pack>>(v1, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun metadata(arg0: &Pack) : 0x1::string::String {
        arg0.metadata
    }

    public(friend) fun mint_pack(arg0: 0x1::string::String, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : Pack {
        Pack{
            id                    : 0x2::object::new(arg8),
            pack_id               : arg0,
            card_pack_template_id : arg1,
            name                  : arg2,
            description           : arg3,
            image_url             : arg4,
            url                   : arg5,
            obtained_at           : 0x2::tx_context::epoch_timestamp_ms(arg8),
            metadata              : arg6,
            open_until            : arg7,
        }
    }

    public(friend) fun name(arg0: &Pack) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun obtained_at(arg0: &Pack) : u64 {
        arg0.obtained_at
    }

    public entry fun open_pack(arg0: Pack, arg1: &mut 0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::warehouse::Warehouse, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.open_until, 2);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = arg0.card_pack_template_id;
        0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::warehouse::decrement_pack_template_unopened_pack_count(0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::warehouse::borrow_card_pack_template(arg1, v1), 1);
        let v2 = 0x1::vector::empty<0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::card::Card>();
        let v3 = open_single_pack(arg1, v1, arg2, v0, &arg0, arg4);
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::card::Card>(&v3)) {
            0x1::vector::push_back<0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::card::Card>(&mut v2, 0x1::vector::pop_back<0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::card::Card>(&mut v3));
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::card::Card>(v3);
        let v5 = 0x1::vector::empty<0x2::object::ID>();
        let v6 = 0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::warehouse::get_linked_pack_template_ids(0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::warehouse::borrow_card_pack_template(arg1, v1));
        let v7 = 0;
        while (v7 < 0x1::vector::length<0x2::object::ID>(v6)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v5, *0x1::vector::borrow<0x2::object::ID>(v6, v7));
            v7 = v7 + 1;
        };
        let v8 = 0;
        while (v8 < 0x1::vector::length<0x2::object::ID>(&v5)) {
            let v9 = 0x1::vector::borrow<0x2::object::ID>(&v5, v8);
            0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::warehouse::decrement_pack_template_unopened_pack_count(0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::warehouse::borrow_card_pack_template(arg1, *v9), 1);
            let v10 = open_single_pack(arg1, *v9, arg2, v0, &arg0, arg4);
            let v11 = 0;
            while (v11 < 0x1::vector::length<0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::card::Card>(&v10)) {
                0x1::vector::push_back<0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::card::Card>(&mut v2, 0x1::vector::pop_back<0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::card::Card>(&mut v10));
                v11 = v11 + 1;
            };
            0x1::vector::destroy_empty<0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::card::Card>(v10);
            v8 = v8 + 1;
        };
        while (!0x1::vector::is_empty<0x2::object::ID>(&v5)) {
            0x1::vector::pop_back<0x2::object::ID>(&mut v5);
        };
        let Pack {
            id                    : v12,
            pack_id               : _,
            card_pack_template_id : _,
            name                  : _,
            description           : _,
            image_url             : _,
            url                   : _,
            obtained_at           : _,
            metadata              : _,
            open_until            : _,
        } = arg0;
        0x2::object::delete(v12);
        let v22 = 0;
        let v23 = 0x1::vector::length<0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::card::Card>(&v2);
        assert!(v23 > 0, 999);
        while (v22 < v23) {
            0x2::transfer::public_transfer<0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::card::Card>(0x1::vector::pop_back<0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::card::Card>(&mut v2), 0x2::tx_context::sender(arg4));
            v22 = v22 + 1;
        };
        0x1::vector::destroy_empty<0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::card::Card>(v2);
    }

    fun open_single_pack(arg0: &mut 0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::warehouse::Warehouse, arg1: 0x2::object::ID, arg2: &0x2::random::Random, arg3: u64, arg4: &Pack, arg5: &mut 0x2::tx_context::TxContext) : vector<0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::card::Card> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0;
        let v3 = 0x1::vector::empty<0x2::object::ID>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::warehouse::get_pack_template_card_templates_and_weights(0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::warehouse::borrow_card_pack_template(arg0, arg1));
        let v6 = 0;
        while (v6 < 0x2::vec_map::size<0x2::object::ID, u64>(v5)) {
            let (v7, v8) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, u64>(v5, v6);
            0x1::vector::push_back<0x2::object::ID>(&mut v3, *v7);
            0x1::vector::push_back<u64>(&mut v4, *v8);
            v6 = v6 + 1;
        };
        let v9 = 0;
        while (v9 < 0x1::vector::length<0x2::object::ID>(&v3)) {
            let v10 = 0x1::vector::borrow<0x2::object::ID>(&v3, v9);
            let v11 = 0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::warehouse::borrow_card_template(arg0, *v10);
            let v12 = 0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::warehouse::get_template_max_supply(v11);
            if (v12 == 0 || 0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::warehouse::get_template_current_supply(v11) < v12) {
                0x1::vector::push_back<0x2::object::ID>(&mut v0, *v10);
                0x1::vector::push_back<u64>(&mut v1, *0x1::vector::borrow<u64>(&v4, v9));
                v2 = v2 + *0x1::vector::borrow<u64>(&v4, v9);
            };
            v9 = v9 + 1;
        };
        assert!(!0x1::vector::is_empty<0x2::object::ID>(&v0), 1);
        let v13 = 0x1::vector::empty<0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::card::Card>();
        let v14 = 0;
        let v15 = 0x2::random::new_generator(arg2, arg5);
        while (v14 < 0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::warehouse::get_pack_template_cards_per_pack(0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::warehouse::borrow_card_pack_template(arg0, arg1))) {
            let v16 = select_template_by_weight(0x2::random::generate_u64_in_range(&mut v15, 0, v2), &v0, &v1);
            let v17 = 0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::warehouse::borrow_card_template(arg0, v16);
            let v18 = 0x1::string::utf8(b"");
            0x1::string::append(&mut v18, 0x1::string::utf8(b"#"));
            0x1::string::append(&mut v18, 0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::warehouse::u64_to_string(0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::warehouse::get_next_id_for_template(v17)));
            0x1::vector::push_back<0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::card::Card>(&mut v13, 0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::card::mint_card(v18, v16, 0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::warehouse::get_template_name(v17), 0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::warehouse::get_template_description(v17), 0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::warehouse::get_template_image_url(v17), 0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::warehouse::get_template_url(v17), 0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::warehouse::get_template_metadata(v17), arg3, 0x1::option::some<0x2::object::ID>(0x2::object::id<Pack>(arg4)), arg5));
            0x75b84322baa701408fca0b2995f2ff40bf0dcabb18eea94075dac8ef933ad2fe::warehouse::increment_template_counter(v17);
            v14 = v14 + 1;
        };
        v13
    }

    fun select_template_by_weight(arg0: u64, arg1: &vector<0x2::object::ID>, arg2: &vector<u64>) : 0x2::object::ID {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(arg1)) {
            let v2 = v0 + *0x1::vector::borrow<u64>(arg2, v1);
            v0 = v2;
            if (arg0 < v2) {
                return *0x1::vector::borrow<0x2::object::ID>(arg1, v1)
            };
            v1 = v1 + 1;
        };
        *0x1::vector::borrow<0x2::object::ID>(arg1, 0)
    }

    public(friend) fun url(arg0: &Pack) : 0x1::string::String {
        arg0.url
    }

    // decompiled from Move bytecode v6
}

