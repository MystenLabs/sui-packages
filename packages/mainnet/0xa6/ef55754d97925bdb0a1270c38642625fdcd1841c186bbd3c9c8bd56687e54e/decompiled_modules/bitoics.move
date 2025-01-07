module 0xa6ef55754d97925bdb0a1270c38642625fdcd1841c186bbd3c9c8bd56687e54e::bitoics {
    struct BITOICS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITOICS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITOICS>(arg0, 8, b"bitoICS.sui", b"bito wrapped ics", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://cbi-website-material.s3.us-east-1.amazonaws.com/icp_logo/icpswap.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BITOICS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITOICS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

