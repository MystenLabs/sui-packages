module 0xc9d50efcd21e1221044408d18ab99274e97f844bf209f08aad44e18df13c95f4::bitond64 {
    struct BITOND64 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITOND64, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITOND64>(arg0, 8, b"bitoND64.sui", b"bito wrapped nd64", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://cbi-website-material.s3.us-east-1.amazonaws.com/icp_logo/ND64.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BITOND64>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITOND64>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

