module 0xf29cab35b6e9b2b5757ffa2c7efac50825a5e25e82810e5d65735f912dede23b::bitoxp {
    struct BITOXP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITOXP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITOXP>(arg0, 8, b"bitoXP.sui", b"bito wrapped windogexp", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://cbi-website-material.s3.us-east-1.amazonaws.com/icp_logo/windogexp.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BITOXP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITOXP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

