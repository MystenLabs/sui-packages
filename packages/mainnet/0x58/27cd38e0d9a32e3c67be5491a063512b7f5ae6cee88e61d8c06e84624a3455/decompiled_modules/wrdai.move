module 0x5827cd38e0d9a32e3c67be5491a063512b7f5ae6cee88e61d8c06e84624a3455::wrdai {
    struct WRDAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WRDAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WRDAI>(arg0, 6, b"WRDAI", b"suiaiword", b"a space trip with suiai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000035447_76ebc4d329.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WRDAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WRDAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

