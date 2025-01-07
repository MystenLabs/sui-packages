module 0x95b735f0faf8fdb412b033eb23bdf5f24c8e64c2365315cba292715a2c598870::rule {
    struct RULE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RULE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RULE>(arg0, 6, b"RULE", b"RULE Your Life", b"RULE YOUR LIFE, RULE THE WORLD!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Designer_21_e4b537ed6f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RULE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RULE>>(v1);
    }

    // decompiled from Move bytecode v6
}

