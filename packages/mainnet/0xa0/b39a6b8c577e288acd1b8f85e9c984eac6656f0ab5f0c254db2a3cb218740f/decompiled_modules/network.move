module 0xa0b39a6b8c577e288acd1b8f85e9c984eac6656f0ab5f0c254db2a3cb218740f::network {
    struct NETWORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: NETWORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NETWORK>(arg0, 9, b"NETWORK", b"Pi", b"Pi ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3774e38b-63b1-492b-b9d8-ac60349f75e8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NETWORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NETWORK>>(v1);
    }

    // decompiled from Move bytecode v6
}

