module 0xc9e44b1f7af4dff2d61b720ee6e780922f96fbc8a1022dc93d46ef78b1481777::TuYv {
    struct TUYV has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TUYV>, arg1: 0x2::coin::Coin<TUYV>) {
        0x2::coin::burn<TUYV>(arg0, arg1);
    }

    fun init(arg0: TUYV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUYV>(arg0, 2, b"TY", b"TuYv Coin", b"god bless you", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUYV>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUYV>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TUYV>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TUYV>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

