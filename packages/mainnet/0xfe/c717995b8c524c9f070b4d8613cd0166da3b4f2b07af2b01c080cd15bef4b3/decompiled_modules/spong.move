module 0xfec717995b8c524c9f070b4d8613cd0166da3b4f2b07af2b01c080cd15bef4b3::spong {
    struct SPONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPONG>(arg0, 6, b"SPONG", b"Spong", b"Are you ready, kids?!  EHHHHHH AYE AYE, CAPTAIN!  I can't hear you!! EHHHHHH AYE AYE, CAPTAIN!  Ahhhhhh!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_22_14_30_25_91733ebddd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

