module 0x6faa43455a36cf29883d07344cc34d1101a6e49e97534a93fa2547a5fc6493b4::pepes {
    struct PEPES has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPES>(arg0, 6, b"PePeS", b"PePe Sui", b"PePe Sui CTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003777_e12f7aa3c3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPES>>(v1);
    }

    // decompiled from Move bytecode v6
}

