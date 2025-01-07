module 0x172a753869d1ab2ddc8214ed94aa2791ccaaa338d243cad73daf34289f84bfa8::matcha {
    struct MATCHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MATCHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MATCHA>(arg0, 6, b"MATCHA", b"Sui Matcha", x"486170707920244d4154434841207769736865732065766572796f6e652061206861707079207765656b656e64200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018628_60c8deb34f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MATCHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MATCHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

