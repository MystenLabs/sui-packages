module 0x50141f8f5f7e070e89ba7723e95908a7708c9752d8aa7ab9c2c45a4a39db6dd6::bitobob {
    struct BITOBOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITOBOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITOBOB>(arg0, 8, b"bitoBOB.sui", b"bito wrapped bob", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://cbi-website-material.s3.us-east-1.amazonaws.com/icp_logo/icbob.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BITOBOB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITOBOB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

