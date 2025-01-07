module 0xb6c88ee01072fba036cd211b6b0ab99366a40750b0ab483f7916dbc074e21068::hal9000 {
    struct HAL9000 has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAL9000, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAL9000>(arg0, 6, b"HAL9000", b"HAL 9000 BOT", b"HAL 9000 is a fictional character and the main antagonist in the 1968 Stanley Kubrick science-fiction film 2001: A Space Odyssey.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/new_11_3c2fbd9941.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAL9000>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAL9000>>(v1);
    }

    // decompiled from Move bytecode v6
}

