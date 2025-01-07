module 0xae07f57b8a308abfc1adb3f4e42c5beaf4b840089a9482223cea315e5a1f9694::jpeg {
    struct JPEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: JPEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JPEG>(arg0, 6, b"JPEG", b"Suitarded.jpeg", x"686f7720746f20637265617420746f6b656e206f6e207375692e6578650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suitarded_cb03849f34.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JPEG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JPEG>>(v1);
    }

    // decompiled from Move bytecode v6
}

