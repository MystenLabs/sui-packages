module 0x3bdd24fada30525c6801d3e3cc328b5fd76df8d73cca07f2ec3dc274b4e6850a::suinu {
    struct SUINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINU>(arg0, 6, b"Suinu", b"Suinu token", b"Suinu is a cute, water-based creature that resembles a small droplet of water. Its semi-transparent, shimmering body catches light beautifully, giving it a radiant, glowing appearance. Suinu is most at home near lakes or streams, where soft ripples naturally surround it, as if it is part of the water itself. Calm and observant, Suinu is always eager to explore new places but does so in a gentle, unhurried way, reflecting its peaceful nature", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_BB_36_B6_D_A71_A_45_AF_9_B1_E_4_EB_49_CD_1257_E_d62883a740.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

