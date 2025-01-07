module 0x232aa14280c0f3bd9f3d2e49073a6d797aafa5fbe327ed77968c413f49c69b6a::bitoyuku {
    struct BITOYUKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITOYUKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITOYUKU>(arg0, 8, b"bitoYUKU.sui", b"bito wrapped yuku", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://cbi-website-material.s3.us-east-1.amazonaws.com/icp_logo/yuku.svg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BITOYUKU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITOYUKU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

