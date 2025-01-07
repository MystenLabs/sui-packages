module 0x56701e75d7dcbecd02cd503772ed8d8f282c5f18e3d2c5382a3f37155947115d::shiva {
    struct SHIVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIVA>(arg0, 9, b"SHIVA", b"Shivawifhat", b"Shivawifhat on sui we are about to go parabolic check the site, X and the whitepaper.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1781007982236401664/Ce2gwqjc.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHIVA>(&mut v2, 130000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIVA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIVA>>(v1);
    }

    // decompiled from Move bytecode v6
}

