module 0x777159fc6afb7d7230c45f6a655b5a7c805d454fc7b458cdb04e639ab43e3d42::gfish {
    struct GFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GFISH>(arg0, 6, b"GFISH", b"GOLDEN KING FISH", b"GOLDEN KING FISH NEW META AND GOOD NARRATIVE ON SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3903_eeb4ac066b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

