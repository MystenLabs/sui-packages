module 0x2a4a7fc2351e045b44eb3d6ce2fc953d2c66767d7406fe1a4665c924aab5abdd::bitocloud {
    struct BITOCLOUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITOCLOUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITOCLOUD>(arg0, 8, b"bitoCLOUD.sui", b"bito wrapped cloud token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://cbi-website-material.s3.us-east-1.amazonaws.com/icp_logo/cloud.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BITOCLOUD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITOCLOUD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

