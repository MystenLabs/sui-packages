module 0x5c710faeaf69993506131100cf4cad8f3c716f92f034cae4fa026dd3ce8303cf::mkts {
    struct MKTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MKTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MKTS>(arg0, 6, b"MKTS", b"Meg king of the sui", b"The king of SUI is here to the moon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5841_3636e497b2.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MKTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MKTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

