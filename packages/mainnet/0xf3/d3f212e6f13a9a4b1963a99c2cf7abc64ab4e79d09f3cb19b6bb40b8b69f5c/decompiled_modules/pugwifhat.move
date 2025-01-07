module 0xf3d3f212e6f13a9a4b1963a99c2cf7abc64ab4e79d09f3cb19b6bb40b8b69f5c::pugwifhat {
    struct PUGWIFHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUGWIFHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGWIFHAT>(arg0, 6, b"PUGWIFHAT", b"PUGGWIFSUI", b"The Pug that doesn't quit.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_12_020912896_941f66f914.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGWIFHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUGWIFHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

