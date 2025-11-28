module 0x6984e35bd396480a152b1cfe390de812d104bc998db57f9636e704e6cd8ce930::susds {
    struct SUSDS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUSDS>, arg1: 0x2::coin::Coin<SUSDS>) {
        0x2::coin::burn<SUSDS>(arg0, arg1);
    }

    fun init(arg0: SUSDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSDS>(arg0, 9, b"sUSDS ", b"sUSDS ", b"This is sUSDS.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uploader.irys.xyz/JAwD3WuvZBoiBootBFwF8yRHCVJngepQaEDTpySDgzs5")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUSDS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSDS>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUSDS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUSDS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

