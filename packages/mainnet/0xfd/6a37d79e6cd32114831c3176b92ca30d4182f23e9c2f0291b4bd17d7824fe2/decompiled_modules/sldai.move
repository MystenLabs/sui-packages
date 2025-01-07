module 0xfd6a37d79e6cd32114831c3176b92ca30d4182f23e9c2f0291b4bd17d7824fe2::sldai {
    struct SLDAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLDAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SLDAI>(arg0, 6, b"SLDAI", b"sleep dog ai", b"sleeping dog ai.the first staff on sui.IS not token IS just a meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000028495_016cfe5efd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SLDAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLDAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

