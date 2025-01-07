module 0x9ced30880376ac37eba2aaba34b7ced72510efc83ab6f07993ffb8c1d0622b5a::rigged {
    struct RIGGED has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIGGED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIGGED>(arg0, 6, b"RIGGED", b"Rigged On Sui", x"2452494747454420546865206d656d65636f696e0a746861742072756e732074686520776f726c64", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002385_3c2573f804.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIGGED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIGGED>>(v1);
    }

    // decompiled from Move bytecode v6
}

