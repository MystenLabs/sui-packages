module 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_attributes {
    struct Attributes has store {
        pos0: 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::base_attributes::Attributes,
    }

    public fun hash(arg0: &Attributes) : 0x1::string::String {
        0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::base_attributes::hash(inner(arg0))
    }

    public(friend) fun insert_misc_value(arg0: &mut Attributes, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::base_attributes::insert_misc_value(inner_mut(arg0), arg1, arg2);
    }

    public(friend) fun new(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_level::Level) : Attributes {
        let v0 = Attributes{pos0: 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::base_attributes::new(0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::static_attributes(), 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::dynamic_attributes(), 0x1::vector::empty<0x1::string::String>())};
        let v1 = &mut v0;
        let v2 = inner_mut(v1);
        0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::base_attributes::insert_misc_value(v2, 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::edition(), arg0);
        let v3 = 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::rarity();
        0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::base_attributes::update_static_value(v2, &v3, arg1);
        let v4 = 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::cover_image();
        0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::base_attributes::update_static_value(v2, &v4, arg2);
        let v5 = 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::foil_pattern();
        0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::base_attributes::update_static_value(v2, &v5, arg3);
        let v6 = 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::background();
        0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::base_attributes::update_dynamic_value(v2, &v6, calc_background_value(&arg1));
        let v7 = &mut v0;
        update_dynamic_values(v7, arg4);
        v0
    }

    public(friend) fun remove_misc_value(arg0: &mut Attributes, arg1: &0x1::string::String) {
        0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::base_attributes::remove_misc_value(inner_mut(arg0), arg1);
    }

    public(friend) fun update_misc_value(arg0: &mut Attributes, arg1: &0x1::string::String, arg2: 0x1::string::String) {
        0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::base_attributes::update_misc_value(inner_mut(arg0), arg1, arg2);
    }

    public fun background(arg0: &Attributes) : 0x1::string::String {
        let v0 = 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::background();
        *0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::base_attributes::borrow_dynamic_value(inner(arg0), &v0)
    }

    fun calc_background_value(arg0: &0x1::string::String) : 0x1::string::String {
        let v0 = 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::rarity_value_common();
        if (arg0 == &v0) {
            0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::background_value_none()
        } else {
            let v2 = 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::rarity_value_rare();
            if (arg0 == &v2) {
                0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::background_value_fire()
            } else {
                let v3 = 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::rarity_value_epic();
                if (arg0 == &v3) {
                    0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::background_value_neon()
                } else {
                    let v4 = 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::rarity_value_legendary();
                    if (arg0 == &v4) {
                        0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::background_value_gold()
                    } else {
                        let v5 = 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::rarity_value_mythic();
                        if (arg0 == &v5) {
                            0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::background_value_astral()
                        } else {
                            0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::values::please_apply_msg()
                        }
                    }
                }
            }
        }
    }

    fun calc_quality_value(arg0: &0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_level::Level) : 0x1::string::String {
        let v0 = 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_level::evolution_stage(arg0);
        if (v0 == 1) {
            0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::quality_value_scuffed()
        } else if (v0 == 2) {
            0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::quality_value_worn()
        } else if (v0 == 3) {
            0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::quality_value_mint()
        } else if (v0 == 4) {
            0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::quality_value_elite()
        } else if (v0 == 5) {
            0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::quality_value_emperor()
        } else {
            0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::values::please_apply_msg()
        }
    }

    public fun cover_image(arg0: &Attributes) : 0x1::string::String {
        let v0 = 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::cover_image();
        *0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::base_attributes::borrow_static_value(inner(arg0), &v0)
    }

    public fun edition(arg0: &Attributes) : 0x1::string::String {
        let v0 = 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::edition();
        *0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::base_attributes::borrow_misc_value(inner(arg0), &v0)
    }

    public fun foil_pattern(arg0: &Attributes) : 0x1::string::String {
        let v0 = 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::foil_pattern();
        *0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::base_attributes::borrow_static_value(inner(arg0), &v0)
    }

    fun inner(arg0: &Attributes) : &0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::base_attributes::Attributes {
        &arg0.pos0
    }

    fun inner_mut(arg0: &mut Attributes) : &mut 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::base_attributes::Attributes {
        &mut arg0.pos0
    }

    public fun quality(arg0: &Attributes) : 0x1::string::String {
        let v0 = 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::quality();
        *0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::base_attributes::borrow_dynamic_value(inner(arg0), &v0)
    }

    public fun rarity(arg0: &Attributes) : 0x1::string::String {
        let v0 = 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::rarity();
        *0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::base_attributes::borrow_static_value(inner(arg0), &v0)
    }

    public(friend) fun update_dynamic_values(arg0: &mut Attributes, arg1: &0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_level::Level) {
        let v0 = false;
        let v1 = calc_quality_value(arg1);
        if (quality(arg0) != v1) {
            let v2 = inner_mut(arg0);
            let v3 = 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::quality();
            0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::base_attributes::update_dynamic_value(v2, &v3, v1);
            v0 = true;
        };
        let v4 = rarity(arg0);
        let v5 = calc_background_value(&v4);
        if (background(arg0) != v5) {
            let v6 = inner_mut(arg0);
            let v7 = 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::background();
            0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::base_attributes::update_dynamic_value(v6, &v7, v5);
            v0 = true;
        };
        if (v0) {
            0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::base_attributes::update_hash_value(inner_mut(arg0));
        };
    }

    // decompiled from Move bytecode v6
}

