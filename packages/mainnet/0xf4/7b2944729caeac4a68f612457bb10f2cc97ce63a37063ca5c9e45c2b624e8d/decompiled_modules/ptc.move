module 0xf47b2944729caeac4a68f612457bb10f2cc97ce63a37063ca5c9e45c2b624e8d::ptc {
    struct PTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTC>(arg0, 6, b"PTC", b"Paper Bitcoin on Sui", x"496620796f7520646f6e27742062656c69657665206974206f7220646f6e2774206765742069742c204920646f6e27742068617665207468652074696d6520746f2074727920746f20636f6e76696e636520796f752c20736f727279202d7361746f736869206e616b616d6f746f200a436f6d6d756e697479207468697320697320796f7572732e204d616b65206974207768617420796f752077696c6c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2676_e057d4c640.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

