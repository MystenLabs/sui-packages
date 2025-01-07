module 0x68c1f596bba55f85ec2543ed1fb4fbc2593d6dc35438c8eb0d9a48aaa04a35f4::cadisorder {
    struct CADISORDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CADISORDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CADISORDER>(arg0, 6, b"CADISORDER", b"chaos and disorder", b"the singularity is today and today is tomorrow ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241203_230124_748_3dfe683a0e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CADISORDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CADISORDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

