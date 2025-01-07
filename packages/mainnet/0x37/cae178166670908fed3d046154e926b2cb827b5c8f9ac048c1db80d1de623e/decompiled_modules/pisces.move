module 0x37cae178166670908fed3d046154e926b2cb827b5c8f9ac048c1db80d1de623e::pisces {
    struct PISCES has drop {
        dummy_field: bool,
    }

    fun init(arg0: PISCES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PISCES>(arg0, 6, b"PISCES", b"Pisces", b"Pisces, the twelfth sign of the zodiac, dances through the celestial waters with a rich history steeped in mythology. Originating from ancient Babylonian astronomy, the sign represents two fish swimming in opposite directions, symbolizing duality and fluidity. In Greek mythology, Pisces is linked to the story of Aphrodite and Eros, who transformed into fish to escape the monster Typhon. This enchanting token weaves together themes of love, escape, and the ultimate connection between the earthly and the divine, making Pisces a whimsical beacon of creativity and intuition.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/241_D1370_F463_42_B0_B60_E_214_B55958_D15_f12a27b8b5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PISCES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PISCES>>(v1);
    }

    // decompiled from Move bytecode v6
}

