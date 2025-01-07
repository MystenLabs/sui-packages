module 0x36d5ee626f37bdb65e5c6a135abcedd08c10c95720fb2c43605d98357421bd32::wtf {
    struct WTF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTF>(arg0, 6, b"WTF", b"What the funding", b"He doesn't why he's here, but he is.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_07_21_41_16_A_cartoon_style_character_walking_away_viewed_from_the_back_facing_an_infinite_road_The_road_stretches_into_the_distance_disappearing_into_the_hor_01878c9358.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WTF>>(v1);
    }

    // decompiled from Move bytecode v6
}

