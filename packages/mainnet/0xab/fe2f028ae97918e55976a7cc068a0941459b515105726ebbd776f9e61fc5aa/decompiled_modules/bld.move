module 0xabfe2f028ae97918e55976a7cc068a0941459b515105726ebbd776f9e61fc5aa::bld {
    struct BLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLD>(arg0, 9, b"BLD", b"Blue dog", b"she likes to play but be carefull don't get bluey. buy me pleaseee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3ffea384-d04e-4a3e-b548-2f9989bbe38a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

