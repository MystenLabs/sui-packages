module 0xa71f591ae311aa67037fa7879d5c4d80080cee39dd737732a476cd55e91a7ede::zenni {
    struct ZENNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZENNI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ZENNI>(arg0, 6, b"ZENNI", b"zenni by SuiAI", b"Zenni AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2184_c60123db93.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZENNI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZENNI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

