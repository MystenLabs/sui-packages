module 0xf84a6fd8814c91e5dbf354da9d0b8830e74495e8aceb45b4e5083338a24090e7::abcxx {
    struct ABCXX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABCXX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABCXX>(arg0, 9, b"ABCXX", b"Lyly", b"112453", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7d9186c5-d618-4e83-b61e-4fd4fd61d4cc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABCXX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABCXX>>(v1);
    }

    // decompiled from Move bytecode v6
}

