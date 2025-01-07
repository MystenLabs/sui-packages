module 0xc4f9de5f49f42270c789a825651ea163a1cae40c47ebf6111ae32cfedc6595ff::aaaaratt {
    struct AAAARATT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAARATT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAARATT>(arg0, 6, b"AaaaRatt", b"Aaa Rat", x"526964696e67206f6e20746865207472656e642c206d616b696e672077617665200a4161615261742074616b696e67206f7665722074686520686f757365206f6620537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000752431_3180cba0d2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAARATT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAARATT>>(v1);
    }

    // decompiled from Move bytecode v6
}

