module 0x5105440690f8bd4f2986c3bf042bee24a5c2d91033309b8e961ad3bb7e14ad72::chlx {
    struct CHLX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHLX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHLX>(arg0, 6, b"CHLX", b"CHILLAXO CTO", b"\"Chill Axo\" is a collection of 2222 quirky and adorable axolotls living in the tranquil paradise of Axolotl Oasis. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CHLX_TOKEN_ICON_45a31f8df1_96e8a58946.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHLX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHLX>>(v1);
    }

    // decompiled from Move bytecode v6
}

