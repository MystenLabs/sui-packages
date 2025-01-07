module 0x478023b7434ee9df1cd105ed34719e106113968114738d5df82f5cb9989fa92b::kevin {
    struct KEVIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEVIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEVIN>(arg0, 6, b"KEVIN", b"Wet Bandits", b"Hiya Pal....Marv and Harry need funds for their Parole hearing in 2 weeks. Let's capture the Christmas spirit and give them the present they have wanted since 1992.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5795_3502495c42.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEVIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEVIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

