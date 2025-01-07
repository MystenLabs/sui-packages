module 0x34ba93ec7873199b6b52a52890351b6ebbed25bb89deaba356669aadbd203865::suiyyds {
    struct SUIYYDS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIYYDS>, arg1: 0x2::coin::Coin<SUIYYDS>) {
        0x2::coin::burn<SUIYYDS>(arg0, arg1);
    }

    fun init(arg0: SUIYYDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIYYDS>(arg0, 2, b"SuiYYDS", b"YYDS", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1683451356727-9d6040640631c381c0bf5391f465c7e2.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIYYDS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIYYDS>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIYYDS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIYYDS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

