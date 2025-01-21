module 0xcccd48611a01e3df38c5d611b8b52b74a7642f02443aa4a4aabc4860c0294278::chlx {
    struct CHLX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHLX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHLX>(arg0, 6, b"CHLX", b"CHILLAXO", b"\"Chill Axo\" is a collection of 2222 quirky and adorable axolotls living in the tranquil paradise of Axolotl Oasis.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CHLX_TOKEN_ICON_45a31f8df1.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHLX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHLX>>(v1);
    }

    // decompiled from Move bytecode v6
}

