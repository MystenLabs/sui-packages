module 0xa46555505a2f416c78e614e1c6b4b96fca31c3c20ba95ec0599aad840b03e183::pengwin {
    struct PENGWIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGWIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGWIN>(arg0, 6, b"PENGWIN", b"Pengwin Sui", b"Win with Pengwin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigrstq2t45fv5ty77vrxcdje23dc2mumohktemih6rjkdpm5kvj4a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGWIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PENGWIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

