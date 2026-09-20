module 0xd1fd6a0cd69113d2a38327af5134f16ee4c53beb52b1a6854c1ae61bb3ddab75::blast {
    struct BLAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAST>(arg0, 9, b"BLAST", b"Blast.fun", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://launchdesk.38.242.215.238.sslip.io/assets/25e345ea9ed1f6cd8c6aed3224ecb70f0178daff4ae737e7d8e98f69a3819ed7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLAST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

