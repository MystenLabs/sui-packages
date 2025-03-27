module 0x460c669acd3f294dc4247a6877ec2532340ffde76162ab201e72fe95355830e7::asui {
    struct ASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASUI>(arg0, 9, b"aSUI", b"asui", b"a staked sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/suilend_points.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

