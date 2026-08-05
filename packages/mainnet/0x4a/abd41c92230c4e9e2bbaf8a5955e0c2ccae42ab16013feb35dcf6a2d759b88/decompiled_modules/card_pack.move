module 0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::card_pack {
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

    struct PackRestored has copy, drop {
        source_object_id: 0x2::object::ID,
        restored_object_id: 0x2::object::ID,
        recipient: address,
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
        0x2::display::add<Pack>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://cardify.net"));
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

    entry fun open_pack(arg0: Pack, arg1: &mut 0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::warehouse::Warehouse, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::warehouse::assert_version(arg1);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.open_until, 20002);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = arg0.card_pack_template_id;
        0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::warehouse::decrement_pack_template_unopened_pack_count(0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::warehouse::borrow_card_pack_template(arg1, v1), 1);
        let v2 = 0x1::vector::empty<0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::card::Card>();
        let v3 = open_single_pack(arg1, v1, arg2, v0, &arg0, arg4);
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::card::Card>(&v3)) {
            0x1::vector::push_back<0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::card::Card>(&mut v2, 0x1::vector::pop_back<0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::card::Card>(&mut v3));
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::card::Card>(v3);
        let v5 = 0x1::vector::empty<0x2::object::ID>();
        let v6 = 0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::warehouse::get_linked_pack_template_ids(0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::warehouse::borrow_card_pack_template(arg1, v1));
        let v7 = 0;
        while (v7 < 0x1::vector::length<0x2::object::ID>(v6)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v5, *0x1::vector::borrow<0x2::object::ID>(v6, v7));
            v7 = v7 + 1;
        };
        let v8 = 0;
        while (v8 < 0x1::vector::length<0x2::object::ID>(&v5)) {
            let v9 = 0x1::vector::borrow<0x2::object::ID>(&v5, v8);
            0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::warehouse::decrement_pack_template_unopened_pack_count(0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::warehouse::borrow_card_pack_template(arg1, *v9), 1);
            let v10 = open_single_pack(arg1, *v9, arg2, v0, &arg0, arg4);
            let v11 = 0;
            while (v11 < 0x1::vector::length<0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::card::Card>(&v10)) {
                0x1::vector::push_back<0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::card::Card>(&mut v2, 0x1::vector::pop_back<0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::card::Card>(&mut v10));
                v11 = v11 + 1;
            };
            0x1::vector::destroy_empty<0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::card::Card>(v10);
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
        let v23 = 0x1::vector::length<0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::card::Card>(&v2);
        assert!(v23 > 0, 20003);
        while (v22 < v23) {
            0x2::transfer::public_transfer<0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::card::Card>(0x1::vector::pop_back<0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::card::Card>(&mut v2), 0x2::tx_context::sender(arg4));
            v22 = v22 + 1;
        };
        0x1::vector::destroy_empty<0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::card::Card>(v2);
    }

    fun open_single_pack(arg0: &mut 0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::warehouse::Warehouse, arg1: 0x2::object::ID, arg2: &0x2::random::Random, arg3: u64, arg4: &Pack, arg5: &mut 0x2::tx_context::TxContext) : vector<0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::card::Card> {
        let v0 = 0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::warehouse::get_pack_template_cards_per_pack(0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::warehouse::borrow_card_pack_template(arg0, arg1));
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0;
        let v4 = 0x1::vector::empty<0x2::object::ID>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::warehouse::get_pack_template_card_templates_and_weights(0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::warehouse::borrow_card_pack_template(arg0, arg1));
        let v7 = 0;
        while (v7 < 0x2::vec_map::size<0x2::object::ID, u64>(v6)) {
            let (v8, v9) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, u64>(v6, v7);
            0x1::vector::push_back<0x2::object::ID>(&mut v4, *v8);
            0x1::vector::push_back<u64>(&mut v5, *v9);
            v7 = v7 + 1;
        };
        let v10 = 0x1::vector::empty<u64>();
        let v11 = 0;
        let v12 = false;
        let v13 = 0;
        while (v13 < 0x1::vector::length<0x2::object::ID>(&v4)) {
            let v14 = 0x1::vector::borrow<0x2::object::ID>(&v4, v13);
            let v15 = 0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::warehouse::borrow_card_template_ref(arg0, *v14);
            let v16 = 0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::warehouse::get_template_current_supply(v15);
            let v17 = 0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::warehouse::get_template_max_supply(v15);
            if (v17 == 0 || v16 < v17) {
                0x1::vector::push_back<0x2::object::ID>(&mut v1, *v14);
                0x1::vector::push_back<u64>(&mut v2, *0x1::vector::borrow<u64>(&v5, v13));
                v3 = v3 + *0x1::vector::borrow<u64>(&v5, v13);
                if (v17 == 0) {
                    0x1::vector::push_back<u64>(&mut v10, 18446744073709551615);
                    v12 = true;
                } else {
                    let v18 = v17 - v16;
                    0x1::vector::push_back<u64>(&mut v10, v18);
                    v11 = v11 + v18;
                };
            };
            v13 = v13 + 1;
        };
        assert!(!0x1::vector::is_empty<0x2::object::ID>(&v1), 20001);
        assert!(v12 || v11 >= v0, 20005);
        let v19 = 0x1::vector::empty<0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::card::Card>();
        let v20 = 0;
        let v21 = 0x2::random::new_generator(arg2, arg5);
        while (v20 < v0) {
            let v22 = select_index_by_weight(0x2::random::generate_u64_in_range(&mut v21, 0, v3 - 1), &v2);
            let v23 = *0x1::vector::borrow<0x2::object::ID>(&v1, v22);
            let v24 = 0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::warehouse::borrow_card_template(arg0, v23);
            let v25 = 0x1::string::utf8(b"");
            0x1::string::append(&mut v25, 0x1::string::utf8(b"#"));
            0x1::string::append(&mut v25, 0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::warehouse::u64_to_string(0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::warehouse::get_next_id_for_template(v24)));
            0x1::vector::push_back<0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::card::Card>(&mut v19, 0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::card::mint_card(v25, v23, 0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::warehouse::get_template_name(v24), 0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::warehouse::get_template_description(v24), 0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::warehouse::get_template_image_url(v24), 0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::warehouse::get_template_url(v24), 0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::warehouse::get_template_metadata(v24), arg3, 0x1::option::some<0x2::object::ID>(0x2::object::id<Pack>(arg4)), arg5));
            0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::warehouse::increment_template_counter(v24);
            let v26 = *0x1::vector::borrow<u64>(&v10, v22);
            let v27 = v26 != 18446744073709551615;
            let v28 = if (v27) {
                v26 - 1
            } else {
                v26
            };
            *0x1::vector::borrow_mut<u64>(&mut v10, v22) = v28;
            let v29 = v27 && v28 == 0;
            let v30 = *0x1::vector::borrow<u64>(&v2, v22);
            let v31 = if (v29) {
                v30
            } else {
                0
            };
            *0x1::vector::borrow_mut<u64>(&mut v2, v22) = v30 - v31;
            v3 = v3 - v31;
            v20 = v20 + 1;
        };
        v19
    }

    public entry fun restore_pack(arg0: &0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::warehouse::SuperAdminCap, arg1: &mut 0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::warehouse::Warehouse, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: 0x2::object::ID, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: u64, arg11: u64, arg12: address, arg13: &mut 0x2::tx_context::TxContext) {
        0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::warehouse::assert_version(arg1);
        let v0 = Pack{
            id                    : 0x2::object::new(arg13),
            pack_id               : arg3,
            card_pack_template_id : arg4,
            name                  : arg5,
            description           : arg6,
            image_url             : arg7,
            url                   : arg8,
            obtained_at           : arg10,
            metadata              : arg9,
            open_until            : arg11,
        };
        let v1 = 0x2::object::id<Pack>(&v0);
        0x4aabd41c92230c4e9e2bbaf8a5955e0c2ccae42ab16013feb35dcf6a2d759b88::warehouse::record_restored_asset(arg1, arg2, v1);
        let v2 = PackRestored{
            source_object_id   : arg2,
            restored_object_id : v1,
            recipient          : arg12,
        };
        0x2::event::emit<PackRestored>(v2);
        0x2::transfer::public_transfer<Pack>(v0, arg12);
    }

    fun select_index_by_weight(arg0: u64, arg1: &vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::option::none<u64>();
        while (v1 < 0x1::vector::length<u64>(arg1)) {
            let v3 = v0 + *0x1::vector::borrow<u64>(arg1, v1);
            v0 = v3;
            if (arg0 < v3 && 0x1::option::is_none<u64>(&v2)) {
                v2 = 0x1::option::some<u64>(v1);
            };
            v1 = v1 + 1;
        };
        assert!(0x1::option::is_some<u64>(&v2), 20004);
        0x1::option::destroy_some<u64>(v2)
    }

    public(friend) fun url(arg0: &Pack) : 0x1::string::String {
        arg0.url
    }

    // decompiled from Move bytecode v7
}

