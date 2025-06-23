module 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values {
    public(friend) fun assert_is_valid_attribute(arg0: &0x1::string::String) {
        let v0 = attributes();
        assert!(0x1::vector::contains<0x1::string::String>(&v0, arg0), 0);
    }

    public(friend) fun assert_is_valid_dynamic_attribute(arg0: &0x1::string::String) {
        let v0 = dynamic_attributes();
        assert!(0x1::vector::contains<0x1::string::String>(&v0, arg0), 0);
    }

    public(friend) fun assert_is_valid_static_attribute(arg0: &0x1::string::String) {
        let v0 = static_attributes();
        assert!(0x1::vector::contains<0x1::string::String>(&v0, arg0), 0);
    }

    public fun attributes() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::append<0x1::string::String>(&mut v0, static_attributes());
        0x1::vector::append<0x1::string::String>(&mut v0, dynamic_attributes());
        v0
    }

    public fun background() : 0x1::string::String {
        0x1::string::utf8(b"Background")
    }

    public fun background_value_astral() : 0x1::string::String {
        0x1::string::utf8(b"Astral")
    }

    public fun background_value_fire() : 0x1::string::String {
        0x1::string::utf8(b"Fire")
    }

    public fun background_value_gold() : 0x1::string::String {
        0x1::string::utf8(b"Gold")
    }

    public fun background_value_neon() : 0x1::string::String {
        0x1::string::utf8(b"Neon")
    }

    public fun background_value_none() : 0x1::string::String {
        0x1::string::utf8(b"None")
    }

    public fun backgrounds() : vector<0x1::string::String> {
        vec_vec_u8_to_vec_string(vector[b"None", b"Fire", b"Neon", b"Gold", b"Astral"])
    }

    public fun cover_image() : 0x1::string::String {
        0x1::string::utf8(b"Cover image")
    }

    public fun cover_image_weights() : vector<vector<u16>> {
        vector[vector[1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], vector[1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], vector[1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], vector[1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], vector[0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]]
    }

    public fun cover_images() : vector<0x1::string::String> {
        vec_vec_u8_to_vec_string(vector[b"Notebook", b"Backpack", b"City Street", b"Multicolor", b"Poster", b"Nightvibe", b"McIka", b"Pixel", b"Neo Pin-up", b"Cult Leader", b"Cybernetic", b"Squid Only", b"Collaborino", b"Traditional", b"Ninja", b"Monster"])
    }

    public fun dynamic_attributes() : vector<0x1::string::String> {
        vec_vec_u8_to_vec_string(vector[b"Background", b"Texture overlay"])
    }

    public fun edition() : 0x1::string::String {
        0x1::string::utf8(b"Edition")
    }

    public fun evolution_thresholds() : vector<u32> {
        vector[1, 10, 100, 1000, 10000]
    }

    public fun foil_pattern() : 0x1::string::String {
        0x1::string::utf8(b"Foil pattern")
    }

    public fun foil_pattern_weights() : vector<vector<u16>> {
        vector[vector[1, 1, 1, 1, 0, 0, 0, 0, 0], vector[1, 1, 1, 1, 0, 0, 0, 0, 0], vector[1, 1, 1, 1, 0, 0, 0, 0, 0], vector[1, 1, 1, 1, 0, 0, 0, 0, 0], vector[0, 0, 0, 0, 1, 1, 1, 1, 1]]
    }

    public fun foil_patterns() : vector<0x1::string::String> {
        vec_vec_u8_to_vec_string(vector[b"Paper", b"Silver", b"Gold", b"Holographic", b"Ika", b"Ika Lux", b"Ika Gold", b"Ika Pink", b"Cyberpunk"])
    }

    public(friend) fun get_attribute_values(arg0: &0x1::string::String) : vector<0x1::string::String> {
        assert_is_valid_attribute(arg0);
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = b"Rarity";
        if (v0 == &v1) {
            rarities()
        } else {
            let v3 = b"Cover image";
            if (v0 == &v3) {
                cover_images()
            } else {
                let v4 = b"Foil pattern";
                if (v0 == &v4) {
                    foil_patterns()
                } else {
                    let v5 = b"Background";
                    if (v0 == &v5) {
                        backgrounds()
                    } else {
                        let v6 = b"Texture overlay";
                        assert!(v0 == &v6, 1);
                        qualities()
                    }
                }
            }
        }
    }

    public fun qualities() : vector<0x1::string::String> {
        vec_vec_u8_to_vec_string(vector[b"Scuffed", b"Worn", b"Mint", b"Elite", b"Emperor"])
    }

    public fun quality() : 0x1::string::String {
        0x1::string::utf8(b"Texture overlay")
    }

    public fun quality_value_elite() : 0x1::string::String {
        0x1::string::utf8(b"Elite")
    }

    public fun quality_value_emperor() : 0x1::string::String {
        0x1::string::utf8(b"Emperor")
    }

    public fun quality_value_mint() : 0x1::string::String {
        0x1::string::utf8(b"Mint")
    }

    public fun quality_value_scuffed() : 0x1::string::String {
        0x1::string::utf8(b"Scuffed")
    }

    public fun quality_value_worn() : 0x1::string::String {
        0x1::string::utf8(b"Worn")
    }

    public fun rarities() : vector<0x1::string::String> {
        vec_vec_u8_to_vec_string(vector[b"Common", b"Rare", b"Epic", b"Legendary", b"Mythic"])
    }

    public fun rarity() : 0x1::string::String {
        0x1::string::utf8(b"Rarity")
    }

    public fun rarity_quantities() : vector<u16> {
        vector[5000, 3000, 1500, 450, 50]
    }

    public fun rarity_quantity_value_common() : u16 {
        5000
    }

    public fun rarity_quantity_value_epic() : u16 {
        1500
    }

    public fun rarity_quantity_value_legendary() : u16 {
        450
    }

    public fun rarity_quantity_value_mythic() : u16 {
        50
    }

    public fun rarity_quantity_value_rare() : u16 {
        3000
    }

    public fun rarity_value_common() : 0x1::string::String {
        0x1::string::utf8(b"Common")
    }

    public fun rarity_value_epic() : 0x1::string::String {
        0x1::string::utf8(b"Epic")
    }

    public fun rarity_value_legendary() : 0x1::string::String {
        0x1::string::utf8(b"Legendary")
    }

    public fun rarity_value_mythic() : 0x1::string::String {
        0x1::string::utf8(b"Mythic")
    }

    public fun rarity_value_rare() : 0x1::string::String {
        0x1::string::utf8(b"Rare")
    }

    public fun static_attributes() : vector<0x1::string::String> {
        vec_vec_u8_to_vec_string(vector[b"Rarity", b"Cover image", b"Foil pattern"])
    }

    fun vec_vec_u8_to_vec_string(arg0: vector<vector<u8>>) : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::reverse<vector<u8>>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg0)) {
            0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(0x1::vector::pop_back<vector<u8>>(&mut arg0)));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg0);
        v0
    }

    // decompiled from Move bytecode v6
}

