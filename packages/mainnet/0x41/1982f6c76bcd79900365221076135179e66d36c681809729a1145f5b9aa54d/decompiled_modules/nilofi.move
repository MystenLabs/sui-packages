module 0x411982f6c76bcd79900365221076135179e66d36c681809729a1145f5b9aa54d::nilofi {
    struct NILOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NILOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NILOFI>(arg0, 6, b"Nilofi", b"Nigga lofi", b"The Yeti Nigga ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1002192971_55ab1a4c6c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NILOFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NILOFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

