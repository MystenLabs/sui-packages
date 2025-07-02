module 0x5152d2ab4a4aa917c02e85925cc53758e0bf73ecf264b6c95dfb9c50dacb8a13::retarder {
    struct RETARDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: RETARDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RETARDER>(arg0, 6, b"Retarder", b"retard", b"Im a retard", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiff3r2ietxf54zuhj6ghnamhaz3fddm3ikiznqtfc2zkcszslwf3i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RETARDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RETARDER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

