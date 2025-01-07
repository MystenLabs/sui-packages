module 0xe7ced859328d7563dd3dda13f1233d4549ad945f739c797d7ba355cf7d6c011::oni {
    struct ONI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONI>(arg0, 6, b"ONI", b"Sui Onigiri", b"$ONI The famous brother of DOGE & NEIRO.  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Onigiri_61e573f4e4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONI>>(v1);
    }

    // decompiled from Move bytecode v6
}

