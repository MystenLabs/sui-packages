module 0xa84a76333406c4eefd0949a81f0fa538c1abce126ae25e81106919d8aa9819db::pi {
    struct PI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PI>(arg0, 6, b"PI", b"PI Sui", b"Official PI Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000079_46a4c6dc7a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PI>>(v1);
    }

    // decompiled from Move bytecode v6
}

