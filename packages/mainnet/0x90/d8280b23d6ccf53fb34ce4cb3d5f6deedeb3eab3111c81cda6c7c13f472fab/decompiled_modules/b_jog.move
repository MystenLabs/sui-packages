module 0x90d8280b23d6ccf53fb34ce4cb3d5f6deedeb3eab3111c81cda6c7c13f472fab::b_jog {
    struct B_JOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_JOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_JOG>(arg0, 9, b"bJOG", b"bToken JOG", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_JOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_JOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

