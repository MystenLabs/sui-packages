module 0xde272a43dc6b2c5a5ed522b23f09849ae30581fc12c8796d3cf3b852bc3b71ac::i {
    struct I has drop {
        dummy_field: bool,
    }

    fun init(arg0: I, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<I>(arg0, 6, b"I", b"Infinite AI", b"Infinite AI is a revolutionary no-code utility DApp that harnesses the power of AI to convert your text into fully functional websites and DApp.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/U_Yu_Bf28_O_400x400_7e2022f462.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<I>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<I>>(v1);
    }

    // decompiled from Move bytecode v6
}

