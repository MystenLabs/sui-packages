module 0xe2b2962247254b2ea11d818f3fa0e66716199bbc6154c139d1ef3d62adab072c::magaai {
    struct MAGAAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGAAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MAGAAI>(arg0, 6, b"MAGAAI", b"MAGA AI by SuiAI", b"MAGA AI, inspired by President Trump's 'Make America Great Again' vision, innovation, and values everyone should embrace, as citizens.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000000686_34acb1f11a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MAGAAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGAAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

