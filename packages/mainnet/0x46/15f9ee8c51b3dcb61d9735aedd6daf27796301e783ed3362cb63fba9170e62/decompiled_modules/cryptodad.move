module 0x4615f9ee8c51b3dcb61d9735aedd6daf27796301e783ed3362cb63fba9170e62::cryptodad {
    struct CRYPTODAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYPTODAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRYPTODAD>(arg0, 6, b"CryptoDad", b"CryptoDad Giancarlo", x"43727970746f446164204769616e6361726c6f0a43727970746f446164790a43727970746f446164790a43727970746f44616479", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731053829797.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRYPTODAD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYPTODAD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

