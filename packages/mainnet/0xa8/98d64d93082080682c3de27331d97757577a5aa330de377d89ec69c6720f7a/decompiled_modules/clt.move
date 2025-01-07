module 0xa898d64d93082080682c3de27331d97757577a5aa330de377d89ec69c6720f7a::clt {
    struct CLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLT>(arg0, 9, b"CLT", b"CHARLOTTE", b"A fine bitch ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e80ac4d0-4f86-4460-8a4b-f8806908b30d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

