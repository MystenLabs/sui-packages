module 0xc31abcec6ad1d8e5efe19f585fb1a94d044674da026deaf904ae6ddb6dfbe974::spmgls {
    struct SPMGLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPMGLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPMGLS>(arg0, 6, b"SPMGLS", b"Super Mega Launch Sui", b"Super Mega Launch Sui Network Today Stay Tuned Big Marketing Today Invite everyone Join in Tg and Check", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9035_bad781a461.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPMGLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPMGLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

