module 0x4f53116961a83f54d5adc23d1a98f0a9e04e7e7cbbe88b6a72b3e7ab2a5a240b::suiala {
    struct SUIALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIALA>(arg0, 6, b"SUIALA", b"Suiala", b"$SUIALA For President.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aa_8326c58f2f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

