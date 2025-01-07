module 0xb59e5a7559e802cecb7c182ebef4e92c7fc923acadbc0a68c462c70f29020840::fdoge {
    struct FDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FDOGE>(arg0, 6, b"FDOGE", b"The First Doge", b"The First Doge on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_deb7e19efa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

