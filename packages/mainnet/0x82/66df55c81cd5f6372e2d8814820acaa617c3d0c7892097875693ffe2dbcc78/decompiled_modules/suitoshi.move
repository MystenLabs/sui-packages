module 0x8266df55c81cd5f6372e2d8814820acaa617c3d0c7892097875693ffe2dbcc78::suitoshi {
    struct SUITOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOSHI>(arg0, 6, b"SUITOSHI", b"AGENT SUITOSHI NAKAMOTO", b"SUITOSHI is the ultimate token of the Sui blockchain, inspired by the relentless Suitoshi Agent. Launched on moonbags.io, it a symbol of agility, precision, and dominance in the crypto realm. With a fierce community and a mission to lead the charge in DeFi.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidqcnmpar7wvsegtejreeuuxlnb2xgwux7py7icdtsnrxng4p3s6q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUITOSHI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

