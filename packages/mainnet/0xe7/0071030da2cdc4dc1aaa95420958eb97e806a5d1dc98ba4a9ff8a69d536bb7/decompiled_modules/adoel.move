module 0xe70071030da2cdc4dc1aaa95420958eb97e806a5d1dc98ba4a9ff8a69d536bb7::adoel {
    struct ADOEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADOEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADOEL>(arg0, 9, b"ADOEL", b"AdoelK", b"Adoel Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2ef7d87b-e435-4f3d-8c62-65020d735862.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADOEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADOEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

