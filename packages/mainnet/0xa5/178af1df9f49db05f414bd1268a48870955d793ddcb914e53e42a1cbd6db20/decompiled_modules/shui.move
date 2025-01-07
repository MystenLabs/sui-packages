module 0xa5178af1df9f49db05f414bd1268a48870955d793ddcb914e53e42a1cbd6db20::shui {
    struct SHUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUI>(arg0, 6, b"Shui", b"SHUI", b"SHUI is a meme coin inspired by the concept of \",\" an essential and ever-present element in life. Just like , SHUI represents fluidity, adaptability, and abundance.  is vital to human existence, found everywhere and connecting all living things. In the world of cryptocurrency, SHUI embodies these qualitiesflowing effortlessly through communities, providing sustenance to its holders, and spreading widely with ease. More than just a digital asset, SHUI symbolizes unity, resilience, and the indispensable role that and by extension, this coinplays in the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4717d2db_c234_4181_b9a0_690b70ac0975_f1ab38c985.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

