module 0x917b87e79640acbb93a7f04e456f6bfdcc0e3196fd3bcba4875ddf29e3e3bed4::coyote {
    struct COYOTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COYOTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COYOTE>(arg0, 6, b"COYOTE", b"Funky Coyote", b"Funky Coyote will fuck everyone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A_j_bitk_A_p_8338f19b6b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COYOTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COYOTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

