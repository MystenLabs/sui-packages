module 0xbdb33e0bf2a9f40245ccf636270e43afb9e27a2020c4d2e8bc4d9c102b65a569::EBLYAT {
    struct EBLYAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: EBLYAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EBLYAT>(arg0, 9, b"GLOOMS3", b"GLOOMS3", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://red-rainy-catfish-636.mypinata.cloud/ipfs/QmY8oLfuXAzE9c1LKgaFAEsVNaektL4W82pLRDX4ChY1KZ")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EBLYAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EBLYAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<EBLYAT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<EBLYAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

