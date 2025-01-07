module 0xb452d0b2433cbead574f1b7a38b028b4a7601e868e8a054877765aa7da44ecd1::peng {
    struct PENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENG>(arg0, 6, b"PENG", b"PEPE DENG", b"With MooDeng reaching great heights on SOL, it is time that SUI brings its own player to the match: With SUI now bullish again... along with it's beta, Pepe, it's time you meet PepeDeng!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pepedeng_cb7e1670d6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

