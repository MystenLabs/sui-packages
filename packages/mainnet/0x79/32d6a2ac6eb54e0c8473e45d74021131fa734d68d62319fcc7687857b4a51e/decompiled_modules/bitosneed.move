module 0x7932d6a2ac6eb54e0c8473e45d74021131fa734d68d62319fcc7687857b4a51e::bitosneed {
    struct BITOSNEED has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITOSNEED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITOSNEED>(arg0, 8, b"bitoSNEED.sui", b"bito wrapped sneed", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://cbi-website-material.s3.us-east-1.amazonaws.com/icp_logo/sneed.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BITOSNEED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITOSNEED>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

