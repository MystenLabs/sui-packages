module 0x13d0415e91845f53a1a70b0c7e4ef34403a2244b418d8388320720190edaf7aa::anchor {
    struct ANCHOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANCHOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANCHOR>(arg0, 6, b"ANCHOR", b"Sui Anchor", b"Steady and unmovable, $ANCHOR keeps your investments grounded in the Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_1_27_99c1282268.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANCHOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANCHOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

