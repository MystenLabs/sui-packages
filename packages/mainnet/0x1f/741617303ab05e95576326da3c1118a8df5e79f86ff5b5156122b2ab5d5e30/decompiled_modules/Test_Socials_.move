module 0x1f741617303ab05e95576326da3c1118a8df5e79f86ff5b5156122b2ab5d5e30::Test_Socials_ {
    struct TEST_SOCIALS_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_SOCIALS_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_SOCIALS_>(arg0, 9, b"SOCIAL", b"Test Socials ", b"Testing socials ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/e6473f2b-7dcb-4bc9-ba95-2ad965c605f6.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST_SOCIALS_>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_SOCIALS_>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

