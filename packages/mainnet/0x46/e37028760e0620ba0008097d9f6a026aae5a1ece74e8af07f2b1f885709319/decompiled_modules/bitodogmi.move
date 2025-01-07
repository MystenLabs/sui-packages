module 0x46e37028760e0620ba0008097d9f6a026aae5a1ece74e8af07f2b1f885709319::bitodogmi {
    struct BITODOGMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITODOGMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITODOGMI>(arg0, 8, b"bitoDOGMI.sui", b"bito wrapped dogmi", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://cbi-website-material.s3.us-east-1.amazonaws.com/icp_logo/dogmi.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BITODOGMI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITODOGMI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

