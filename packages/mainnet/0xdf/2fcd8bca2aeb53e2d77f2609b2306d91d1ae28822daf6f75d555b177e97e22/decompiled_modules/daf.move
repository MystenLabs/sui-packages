module 0xdf2fcd8bca2aeb53e2d77f2609b2306d91d1ae28822daf6f75d555b177e97e22::daf {
    struct DAF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAF>(arg0, 6, b"DAF", b"adf", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suipad.online/api/images/7c3be910a68380ab5265fca7a3f14e79558e470b5212c5e0e6fdc6da2b2fa1b4.jpg")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAF>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DAF>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

