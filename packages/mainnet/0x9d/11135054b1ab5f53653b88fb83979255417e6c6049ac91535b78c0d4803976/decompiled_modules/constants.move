module 0x9d11135054b1ab5f53653b88fb83979255417e6c6049ac91535b78c0d4803976::constants {
    public fun offering_active_state() : u8 {
        201
    }

    public fun offering_cancelled_state() : u8 {
        203
    }

    public fun offering_completed_state() : u8 {
        202
    }

    public fun offering_draft_state() : u8 {
        200
    }

    public fun one_hundred_percent() : u64 {
        10000
    }

    public fun one_percent() : u64 {
        100
    }

    public fun price_factor() : u64 {
        10000
    }

    public fun round_presale() : u8 {
        100
    }

    public fun round_redeem() : u8 {
        102
    }

    public fun round_trading() : u8 {
        101
    }

    public fun token_decimals() : u64 {
        1000000
    }

    public fun wat_display_creator() : 0x1::string::String {
        0x1::string::utf8(b"ARTTOO")
    }

    public fun wat_display_description() : 0x1::string::String {
        0x1::string::utf8(b"A wrapper holding your purchased 'Life on Jupiter' (LOJ) presale tokens. The enclosed LOJ coins are locked during the presale and will become tradable after presale ends.")
    }

    public fun wat_display_image_url() : 0x1::string::String {
        0x1::string::utf8(b"https://arttoo.co/artworks/coin/wat.png")
    }

    public fun wat_display_name() : 0x1::string::String {
        0x1::string::utf8(b"Life on Jupiter WAT")
    }

    public fun wat_display_project_url() : 0x1::string::String {
        0x1::string::utf8(b"https://arttoo.co")
    }

    // decompiled from Move bytecode v6
}

