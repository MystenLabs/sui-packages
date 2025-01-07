module 0x3ad163c7f232257bce6c1bd1028d419fa24450a651c08122b3f73a09a0fbfad7::sfb {
    struct SFB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFB>(arg0, 6, b"SFB", b"SUI FUNNY Bunny", b"The Bunny is setting up the stage ....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/funy_c3c8eeee9d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFB>>(v1);
    }

    // decompiled from Move bytecode v6
}

