module 0x30793c33ec47ac6d4fa5451ba41b970821ea72db24ff207a7d3ea0bfcaaaafde::smeme {
    struct SMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMEME>(arg0, 6, b"Smeme", b"Sui Memecoin", b"the real Meme coin is on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/28301_1ca62f2715.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

