module 0xa8410f844caeaa5e94a05ac54db05703d95822a700b995f380c415b0ee253bc9::hemno {
    struct HEMNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEMNO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEMNO>(arg0, 6, b"HEMNO", b"Hemno Cat", b"Welcome to Hemno's world! Meet Hemno, the crazy Chihuahua of Sui Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018247_155b87bace.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEMNO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEMNO>>(v1);
    }

    // decompiled from Move bytecode v6
}

