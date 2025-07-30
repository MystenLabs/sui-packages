module 0x8346c825f31faf61e2f8738c598eb3805350da0f74873f964233cc40854116d9::SHIBUNAUT {
    struct SHIBUNAUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBUNAUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBUNAUT>(arg0, 6, b"Shibu the Astronaut", b"SHIBUNAUT", b"Shibu the Astronaut is a meme coin that blasts off to the moon! Combining the cuteness of Shibu with the bravery of an astronaut, this coin is set to explore new financial galaxies. Join the mission and hodl for interstellar gains!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"blob:https://mfc.club/b8219e51-18d8-4d45-bec6-e3fd61267733")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBUNAUT>>(v0, @0x691c5d4f7bd7c39b39907d3ca01b8c2643c87de134766ca4f78be51e0a9fde1b);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIBUNAUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

