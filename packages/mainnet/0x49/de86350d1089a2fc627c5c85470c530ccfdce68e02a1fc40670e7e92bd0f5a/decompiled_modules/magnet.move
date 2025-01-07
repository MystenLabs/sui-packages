module 0x49de86350d1089a2fc627c5c85470c530ccfdce68e02a1fc40670e7e92bd0f5a::magnet {
    struct MAGNET has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGNET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGNET>(arg0, 9, b"MAGNET", b"Magnet", x"546865204d41474e4554206d65616e7320736f6d657468696e67206974206d65616e20686f7065206974206d65616e732062656c6965766520696e20736f6d657468696e67206974e2809973206f757220776f726c642c2065766572796f6e6520656c7365206973206a757374206c6976696e6720696e206974", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmR1M3kHVCEGuRjFkMw3gTtJVuUE946KTw9RPVijKm6CoY?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MAGNET>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGNET>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGNET>>(v1);
    }

    // decompiled from Move bytecode v6
}

