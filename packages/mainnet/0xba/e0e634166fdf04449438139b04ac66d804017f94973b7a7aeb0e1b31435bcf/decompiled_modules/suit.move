module 0xbae0e634166fdf04449438139b04ac66d804017f94973b7a7aeb0e1b31435bcf::suit {
    struct SUIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIT>(arg0, 6, b"SUIT", b"Suit", x"53756974206f6e20737569200a45646974207769746820796f7572206661766f72697465204b4f4c20616e64206d656d650a4c657473206d616b6520697420726561647920666f7220612064696e6e6572207769746820737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000033388_781eda5e02.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

