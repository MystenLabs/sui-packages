module 0xc1b1f4228cdf2bef6eff8022e2b80124026b10568f84e39396b80350b59373bb::crt {
    struct CRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRT>(arg0, 6, b"CRT", b"crazy toad", b"If you don't have houses or flies, it's better to catch the toad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aacb0a35_f47e_43c3_a064_5044d7d27f4a_5ca0ef94de.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

