module 0x52678303b5971a9751a8f09df48e2c6037fac96a06bdda3ebf7d687d263b1660::beng {
    struct BENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENG>(arg0, 6, b"BENG", b"BURNPENGU", b"Just a chill burned pengu.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004550_3a3cc9094f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

