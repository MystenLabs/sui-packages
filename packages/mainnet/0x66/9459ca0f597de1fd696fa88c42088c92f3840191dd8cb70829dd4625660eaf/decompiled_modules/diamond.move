module 0x669459ca0f597de1fd696fa88c42088c92f3840191dd8cb70829dd4625660eaf::diamond {
    struct DIAMOND has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIAMOND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIAMOND>(arg0, 9, b"DIAMOND", b"Drake's Dog", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIAMOND>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIAMOND>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DIAMOND>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DIAMOND>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

