module 0x8a6069db103fd734bc7db67f4f58912d795ae3c4288ed85b4e76efb91818acf6::yum {
    struct YUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUM>(arg0, 6, b"YUM", b"YUMI SUI", x"59756d69206973206465656361797a277320646f67204f574e4552204f462046574f470a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i_Uw_Z_Lf_Ek_400x400_a7c764c07c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

