module 0xf89c7b5ee4829da8baf019817bff23c5fe6586ecddf0d7c28c2735e1c5bc2083::pai {
    struct PAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PAI>(arg0, 6, b"PAI", b"PAI by SuiAI", b"PAI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/images_15_0db7abfa22.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

