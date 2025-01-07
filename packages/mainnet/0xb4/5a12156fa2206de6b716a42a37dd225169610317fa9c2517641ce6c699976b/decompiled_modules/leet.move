module 0xb45a12156fa2206de6b716a42a37dd225169610317fa9c2517641ce6c699976b::leet {
    struct LEET has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEET>(arg0, 6, b"Leet", b"leet", b"1337 meme on sui. made in response to the rugs. fixed supply 100%. will never build on it or change it. legit sui meme coin. trade freely", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731017489047.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEET>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

