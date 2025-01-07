module 0xf0672059c073443e370a582acf90f68515c4f2e1550c39c064bc57ddf07199f4::glennsui {
    struct GLENNSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLENNSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLENNSUI>(arg0, 6, b"Glennsui", b"Glenn", x"4d65657420476c65656e20746865206661696c6564204149206578706572696d656e7420747279696e6720746f20626f6e64206f6e207468652073756920626c6f636b636861696e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Jibrezj1_400x400_dfd34b7eef.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLENNSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLENNSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

