module 0x70bb78c2751e18398ce6b1fe92ecc8a6046b16d0471f23dd4f1c4c84a215bb93::adamwifsui {
    struct ADAMWIFSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADAMWIFSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADAMWIFSUI>(arg0, 6, b"ADAMWIFSUI", b"ADAMWIFHAT", b"The Pug that doesn't quit.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_12_021037512_8532dc9e1c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADAMWIFSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADAMWIFSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

