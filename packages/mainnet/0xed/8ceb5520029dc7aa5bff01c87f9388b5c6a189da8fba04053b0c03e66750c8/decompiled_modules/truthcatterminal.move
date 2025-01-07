module 0xed8ceb5520029dc7aa5bff01c87f9388b5c6a189da8fba04053b0c03e66750c8::truthcatterminal {
    struct TRUTHCATTERMINAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUTHCATTERMINAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUTHCATTERMINAL>(arg0, 6, b"TruthCatTerminal", b"Truth Cat Terminal", b"Truth Cat Terminal. first ai cat on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/asqqcxzzx_e437c439b2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUTHCATTERMINAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUTHCATTERMINAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

