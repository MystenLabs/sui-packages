module 0xecb1449d80d1954a9f9d7d5bce8905a92c85283636ca3a92988fa147aa572d5::WardFeathercloak {
    struct WARDFEATHERCLOAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WARDFEATHERCLOAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WARDFEATHERCLOAK>(arg0, 0, b"COS", b"Ward Feathercloak", b"Perch high in the arms of the Ward... feast upon the uncharted...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Ward_Feathercloak.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WARDFEATHERCLOAK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WARDFEATHERCLOAK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

