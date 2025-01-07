module 0x72655d4bf50a4cd352b9ecb6a7bc2ce0fd9a5c164838129d830138b74fe3b32e::wvw {
    struct WVW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WVW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WVW>(arg0, 9, b"WVW", b"WaVeWe", b"WaveWe is a meme token created on a notion that Wave is continuous as could be seen on the ticker WVW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bafde181-18bc-484d-8016-9ad1ecd9635a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WVW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WVW>>(v1);
    }

    // decompiled from Move bytecode v6
}

