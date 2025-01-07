module 0x205cc30108afd2468d06ef5f80654422f350ad44ae8874d4661a1d9c423e65d4::ebisui {
    struct EBISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EBISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EBISUI>(arg0, 6, b"EBISUI", b"$EBISUI", b"The $EBISUI sticker has proven that even a goofy emoji can become a global phenomenon. Its story will be told for years to come, as a lesson about the unexpected and opportunity in the cryptocurrency world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ptichka_500_500_px_5_52a7a896fd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EBISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EBISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

