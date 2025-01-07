module 0x8d7b8cb4b1c931e05ce8ac3a6e10a3d15fbb66863dc78177c41abffe09bc40a6::QWERTANE {
    struct QWERTANE has drop {
        dummy_field: bool,
    }

    fun init(arg0: QWERTANE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QWERTANE>(arg0, 9, b"QWERTANE", b"QWERTANE", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://red-rainy-catfish-636.mypinata.cloud/ipfs/QmY8oLfuXAzE9c1LKgaFAEsVNaektL4W82pLRDX4ChY1KZ")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QWERTANE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QWERTANE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<QWERTANE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<QWERTANE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

