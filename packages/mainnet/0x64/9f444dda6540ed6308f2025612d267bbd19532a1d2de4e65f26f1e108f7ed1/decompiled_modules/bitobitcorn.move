module 0x649f444dda6540ed6308f2025612d267bbd19532a1d2de4e65f26f1e108f7ed1::bitobitcorn {
    struct BITOBITCORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITOBITCORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITOBITCORN>(arg0, 8, b"bitoBITCORN.sui", b"bito wrapped bitcorn", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://cbi-website-material.s3.us-east-1.amazonaws.com/icp_logo/bitcorn.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BITOBITCORN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITOBITCORN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

