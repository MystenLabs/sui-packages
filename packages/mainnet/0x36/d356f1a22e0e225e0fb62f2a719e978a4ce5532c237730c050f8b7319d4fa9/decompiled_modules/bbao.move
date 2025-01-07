module 0x36d356f1a22e0e225e0fb62f2a719e978a4ce5532c237730c050f8b7319d4fa9::bbao {
    struct BBAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBAO>(arg0, 9, b"BBAO", b"Uncle Bao", x"e68ab1e58f94e69cace58f9420e4b880e58faae4bc9ae7ac91e79a84e78cabefbd9ee585a8e7bd91e698b5e7a7b0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/19e20ea6-434c-4335-8e6b-04fe7a479236.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

