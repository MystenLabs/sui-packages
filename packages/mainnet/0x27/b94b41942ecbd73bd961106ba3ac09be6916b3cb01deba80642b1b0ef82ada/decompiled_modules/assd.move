module 0x27b94b41942ecbd73bd961106ba3ac09be6916b3cb01deba80642b1b0ef82ada::assd {
    struct ASSD has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ASSD>, arg1: 0x2::coin::Coin<ASSD>) {
        0x2::coin::burn<ASSD>(arg0, arg1);
    }

    fun init(arg0: ASSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASSD>(arg0, 9, b"TMPL", b"Template Token", b"A template token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/logo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASSD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASSD>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ASSD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ASSD>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

