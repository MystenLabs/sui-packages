module 0x1e5c428d2fad220fda018a085abcc045cd18e16f28fb13d95c354609deef0870::bitoghost {
    struct BITOGHOST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITOGHOST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITOGHOST>(arg0, 8, b"bitoGHOST.sui", b"bito wrapped ghost", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://cbi-website-material.s3.us-east-1.amazonaws.com/icp_logo/icghost.webp"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BITOGHOST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITOGHOST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

