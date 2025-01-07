module 0xa09e11885b1b91f146bf0fb2e85fa7d00c02f6a56ae6be527eb2af306fefe0b0::sui_odyssey {
    struct SUI_ODYSSEY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUI_ODYSSEY>, arg1: 0x2::coin::Coin<SUI_ODYSSEY>) {
        0x2::coin::burn<SUI_ODYSSEY>(arg0, arg1);
    }

    fun init(arg0: SUI_ODYSSEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_ODYSSEY>(arg0, 9, b"ODYSSEY", b"SUI Odyssey", b"https://x.com/suiodyssey https://t.co/Aw38EXjmyE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GaX_MyMXUAAMV9F?format=jpg&name=medium")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_ODYSSEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_ODYSSEY>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUI_ODYSSEY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUI_ODYSSEY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

