module 0xf21b10377261a9580403e4df4ae843722c2e25ff7757758260739568795c141e::suinimal {
    struct SUINIMAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINIMAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINIMAL>(arg0, 6, b"SUINIMAL", b".SUINIMAL", b"Suinimal $SUINIMAL is a meme coin with no intrinsic value or expectation of financial return. There is no formal team or roadmap. the coin is completely useless and for entertainment purposes only.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Green_Illustrative_World_Animal_Day_Instagram_Post_2281f302fa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINIMAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINIMAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

