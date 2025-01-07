module 0xae4fa8cde50629b17a19f17df906b6b76dad7cf2f191faa60bdb387562be6689::pfish {
    struct PFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PFISH>(arg0, 6, b"PFISH", b"Pet Fish on sui", b"Meet my pet fish!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5918_87cbfdf36b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

