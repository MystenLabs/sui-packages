module 0x6f99dfe1aadf2460560590eec717d68a3c3594e0de78044cee8ecc38c2f70695::drek {
    struct DREK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DREK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DREK>(arg0, 6, b"DREK", b"Drek on sui", b"Drek is an innovative memecoin on the Sui blockchain that combines humor with the simplicity of a farmers life. Inspired by the hard work and wisdom of past generations, Drek is designed to entertain while fostering a strong community within the ever-evolving crypto ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000046403_d8b37f49df.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DREK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DREK>>(v1);
    }

    // decompiled from Move bytecode v6
}

