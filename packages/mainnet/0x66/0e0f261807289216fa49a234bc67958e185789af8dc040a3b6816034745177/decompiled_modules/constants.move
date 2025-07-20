module 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::constants {
    public fun default_description() : vector<u8> {
        b"Monkey Battle Character"
    }

    public fun default_type_weight() : u64 {
        100
    }

    public fun item_type_accessory() : u64 {
        3
    }

    public fun item_type_hat() : u64 {
        0
    }

    public fun item_type_pants() : u64 {
        2
    }

    public fun item_type_shirt() : u64 {
        1
    }

    public fun max_image_size() : u64 {
        200000
    }

    public fun max_weight() : u64 {
        100
    }

    public fun min_royalty_amount() : u64 {
        100000000
    }

    public fun min_weight() : u64 {
        50
    }

    public fun raid_cooldown_ms() : u64 {
        86400000
    }

    public fun render_base_url() : vector<u8> {
        b"https://service.megawavesmakers.com/render"
    }

    public fun royalty_bp() : u16 {
        500
    }

    public fun weight_penalty() : u64 {
        20
    }

    public fun weight_recovery() : u64 {
        5
    }

    // decompiled from Move bytecode v6
}

