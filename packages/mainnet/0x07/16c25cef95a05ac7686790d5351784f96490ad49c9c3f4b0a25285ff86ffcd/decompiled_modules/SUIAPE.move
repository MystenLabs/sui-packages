module 0x716c25cef95a05ac7686790d5351784f96490ad49c9c3f4b0a25285ff86ffcd::SUIAPE {
    struct SUIAPE has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIAPE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIAPE>>(0x2::coin::mint<SUIAPE>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun transfer(arg0: 0x2::coin::TreasuryCap<SUIAPE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAPE>>(arg0, arg1);
    }

    fun init(arg0: SUIAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAPE>(arg0, 6, b"SUIAPE", b"SUIAPE", b"description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"icon_image")), arg1);
        let v2 = v0;
        0x2::pay::keep<SUIAPE>(0x2::coin::from_balance<SUIAPE>(0x2::coin::mint_balance<SUIAPE>(&mut v2, 10000000000000000000), arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIAPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAPE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

