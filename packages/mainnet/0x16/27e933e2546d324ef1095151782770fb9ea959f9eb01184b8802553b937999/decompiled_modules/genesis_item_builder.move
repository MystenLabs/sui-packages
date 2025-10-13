module 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::genesis_item_builder {
    struct Item {
        rarity: 0x1::string::String,
        cover_image: 0x1::string::String,
        foil_pattern: 0x1::string::String,
        edition: 0x1::string::String,
    }

    struct ItemBuilder has store {
        initial_amount: u16,
        rarities: vector<0x1::string::String>,
        rarity_quantities: vector<u16>,
        cover_images: vector<0x1::string::String>,
        cover_image_value_quantities: vector<vector<u16>>,
        foil_patterns: vector<0x1::string::String>,
        foil_pattern_value_quantities: vector<vector<u16>>,
    }

    fun assert_can_generate_item(arg0: &ItemBuilder) {
        assert!(items_remaining(arg0) > 0, 3);
    }

    fun calc_attribute_value_quantities(arg0: vector<u16>, arg1: vector<vector<u16>>) : vector<vector<u16>> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<u16>(&arg0)) {
            let v2 = *0x1::vector::borrow<u16>(&arg0, v1);
            let v3 = *0x1::vector::borrow<vector<u16>>(&arg1, v1);
            let v4 = 0;
            0x1::vector::reverse<u16>(&mut v3);
            let v5 = 0;
            while (v5 < 0x1::vector::length<u16>(&v3)) {
                v4 = v4 + 0x1::vector::pop_back<u16>(&mut v3);
                v5 = v5 + 1;
            };
            0x1::vector::destroy_empty<u16>(v3);
            let v6 = vector[];
            0x1::vector::reverse<u16>(&mut v3);
            let v7 = 0;
            while (v7 < 0x1::vector::length<u16>(&v3)) {
                0x1::vector::push_back<u16>(&mut v6, v2 * 0x1::vector::pop_back<u16>(&mut v3) / v4);
                v7 = v7 + 1;
            };
            0x1::vector::destroy_empty<u16>(v3);
            let v8 = 0;
            0x1::vector::reverse<u16>(&mut v6);
            let v9 = 0;
            while (v9 < 0x1::vector::length<u16>(&v6)) {
                v8 = v8 + 0x1::vector::pop_back<u16>(&mut v6);
                v9 = v9 + 1;
            };
            0x1::vector::destroy_empty<u16>(v6);
            let v10 = v2 - v8;
            let v11 = 0;
            while (v10 > 0) {
                let v12 = 0x1::vector::borrow_mut<u16>(&mut v6, v11);
                *v12 = *v12 + 1;
                v10 = v10 - 1;
                let v13 = v11 + 1;
                v11 = v13 % 0x1::vector::length<u16>(&v6);
            };
            let v14 = 0;
            0x1::vector::reverse<u16>(&mut v6);
            let v15 = 0;
            while (v15 < 0x1::vector::length<u16>(&v6)) {
                v14 = v14 + 0x1::vector::pop_back<u16>(&mut v6);
                v15 = v15 + 1;
            };
            0x1::vector::destroy_empty<u16>(v6);
            assert!(v14 == v2, 0);
            0x1::vector::push_back<vector<u16>>(&mut v0, v6);
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun consume(arg0: Item) : (0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String) {
        let Item {
            rarity       : v0,
            cover_image  : v1,
            foil_pattern : v2,
            edition      : v3,
        } = arg0;
        (v0, v1, v2, v3)
    }

    public(friend) fun create_item_builder() : ItemBuilder {
        new_item_builder(0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::rarities(), 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::rarity_quantities(), 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::cover_images(), 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::cover_image_weights(), 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::foil_patterns(), 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::foil_pattern_weights())
    }

    public(friend) fun generate_common_item(arg0: &mut ItemBuilder, arg1: &mut 0x2::random::RandomGenerator) : Item {
        assert_can_generate_item(arg0);
        let v0 = 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::rarity_value_common();
        let (v1, v2) = 0x1::vector::index_of<0x1::string::String>(&arg0.rarities, &v0);
        assert!(v1, 4);
        let v3 = 0x1::vector::borrow_mut<u16>(&mut arg0.rarity_quantities, v2);
        assert!(*v3 > 0, 2);
        *v3 = *v3 - 1;
        generate_rarity_item(arg0, v0, v2, arg1)
    }

    public(friend) fun generate_item(arg0: &mut ItemBuilder, arg1: &mut 0x2::random::RandomGenerator) : Item {
        assert_can_generate_item(arg0);
        let v0 = &mut arg0.rarity_quantities;
        let (v1, v2) = pick_and_process_random_attribute_value(arg1, v0, &arg0.rarities);
        generate_rarity_item(arg0, v2, v1, arg1)
    }

    fun generate_rarity_item(arg0: &mut ItemBuilder, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::random::RandomGenerator) : Item {
        let v0 = 0x1::vector::borrow_mut<vector<u16>>(&mut arg0.cover_image_value_quantities, arg2);
        let (_, v2) = pick_and_process_random_attribute_value(arg3, v0, &arg0.cover_images);
        let v3 = 0x1::vector::borrow_mut<vector<u16>>(&mut arg0.foil_pattern_value_quantities, arg2);
        let (_, v5) = pick_and_process_random_attribute_value(arg3, v3, &arg0.foil_patterns);
        Item{
            rarity       : arg1,
            cover_image  : v2,
            foil_pattern : v5,
            edition      : 0x1::u16::to_string(arg0.initial_amount - items_remaining(arg0)),
        }
    }

    public fun items_remaining(arg0: &ItemBuilder) : u16 {
        let v0 = 0;
        let v1 = arg0.rarity_quantities;
        0x1::vector::reverse<u16>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u16>(&v1)) {
            v0 = v0 + 0x1::vector::pop_back<u16>(&mut v1);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u16>(v1);
        v0
    }

    fun new_item_builder(arg0: vector<0x1::string::String>, arg1: vector<u16>, arg2: vector<0x1::string::String>, arg3: vector<vector<u16>>, arg4: vector<0x1::string::String>, arg5: vector<vector<u16>>) : ItemBuilder {
        assert!(0x1::vector::length<u16>(&arg1) == 0x1::vector::length<0x1::string::String>(&arg0), 1);
        assert!(0x1::vector::length<u16>(&arg1) == 0x1::vector::length<vector<u16>>(&arg3), 1);
        assert!(0x1::vector::length<u16>(&arg1) == 0x1::vector::length<vector<u16>>(&arg5), 1);
        let v0 = 0;
        0x1::vector::reverse<u16>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u16>(&arg1)) {
            v0 = v0 + 0x1::vector::pop_back<u16>(&mut arg1);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<u16>(arg1);
        ItemBuilder{
            initial_amount                : v0,
            rarities                      : arg0,
            rarity_quantities             : arg1,
            cover_images                  : arg2,
            cover_image_value_quantities  : calc_attribute_value_quantities(arg1, arg3),
            foil_patterns                 : arg4,
            foil_pattern_value_quantities : calc_attribute_value_quantities(arg1, arg5),
        }
    }

    fun pick_and_process_random_attribute_value(arg0: &mut 0x2::random::RandomGenerator, arg1: &mut vector<u16>, arg2: &vector<0x1::string::String>) : (u64, 0x1::string::String) {
        let v0 = pick_random_index(*arg1, arg0);
        let v1 = 0x1::vector::borrow_mut<u16>(arg1, v0);
        assert!(*v1 > 0, 2);
        *v1 = *v1 - 1;
        (v0, *0x1::vector::borrow<0x1::string::String>(arg2, v0))
    }

    fun pick_random_index(arg0: vector<u16>, arg1: &mut 0x2::random::RandomGenerator) : u64 {
        let v0 = 0;
        0x1::vector::reverse<u16>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u16>(&arg0)) {
            v0 = v0 + 0x1::vector::pop_back<u16>(&mut arg0);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<u16>(arg0);
        let v2 = 0x2::random::generate_u16_in_range(arg1, 1, v0);
        let v3 = 0;
        loop {
            let v4 = *0x1::vector::borrow<u16>(&arg0, v3);
            if (v2 <= v4) {
                break
            };
            v2 = v2 - v4;
            v3 = v3 + 1;
        };
        v3
    }

    // decompiled from Move bytecode v6
}

