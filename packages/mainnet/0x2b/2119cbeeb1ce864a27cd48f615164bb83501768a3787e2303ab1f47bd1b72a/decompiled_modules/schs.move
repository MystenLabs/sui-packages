module 0x2b2119cbeeb1ce864a27cd48f615164bb83501768a3787e2303ab1f47bd1b72a::schs {
    struct SCHS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCHS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCHS>(arg0, 6, b"SCHS", b"Smoking Chicken Fish On Sui", b"Smoking Chicken Fish On Sui for community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sss_37fc43c3ee.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCHS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCHS>>(v1);
    }

    // decompiled from Move bytecode v6
}

