module 0x76e2ee537b0bc3caaeb820595491bb12aa2a0d6c9c12aede3519ff0e86d37903::btcvc {
    struct BTCVC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCVC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCVC>(arg0, 8, b"BTCvc", b"BTCvc", b"Powered by Vishwa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suiscan.xyz/static/media/SuiFullLogo.15649cdd512a7fd210688c7c3f05eb0d.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTCVC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCVC>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun test_burn(arg0: &mut 0x2::coin::TreasuryCap<BTCVC>, arg1: 0x2::coin::Coin<BTCVC>) {
        0x2::coin::burn<BTCVC>(arg0, arg1);
    }

    public entry fun test_mint(arg0: &mut 0x2::coin::TreasuryCap<BTCVC>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BTCVC>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

