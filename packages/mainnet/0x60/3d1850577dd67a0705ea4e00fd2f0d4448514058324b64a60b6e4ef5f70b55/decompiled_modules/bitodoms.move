module 0x603d1850577dd67a0705ea4e00fd2f0d4448514058324b64a60b6e4ef5f70b55::bitodoms {
    struct BITODOMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITODOMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITODOMS>(arg0, 8, b"bitoDOMS.sui", b"bito wrapped dominics pizza", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://cbi-website-material.s3.us-east-1.amazonaws.com/icp_logo/doms.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BITODOMS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITODOMS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

