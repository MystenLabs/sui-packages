module 0xf2e60b3afa2bdbd68c7b3cc8278ad4951ce58d871c1fd12aeb6a8f295beade33::test_socials_ {
    struct TEST_SOCIALS_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_SOCIALS_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_SOCIALS_>(arg0, 9, b"SOCIAL", b"test socials ", b"testing socials and tags ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/8ff4c3c6-9def-45b2-8ee2-c186924cb026.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST_SOCIALS_>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_SOCIALS_>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

