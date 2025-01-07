module 0x8308717a1a4c9bbd9928c8e6b99000eaad87a40ea3d6860b482cc0582c4e9a46::exe {
    struct EXE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EXE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EXE>(arg0, 6, b"EXE", b"suitarded.exe", x"686f7720746f206372657420746f6b656e206f6e207375692e6578650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suitarded_79d558cd8a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EXE>>(v1);
    }

    // decompiled from Move bytecode v6
}

