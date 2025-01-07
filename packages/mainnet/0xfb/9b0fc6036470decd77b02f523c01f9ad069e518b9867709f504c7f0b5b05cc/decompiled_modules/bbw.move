module 0xfb9b0fc6036470decd77b02f523c01f9ad069e518b9867709f504c7f0b5b05cc::bbw {
    struct BBW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBW>(arg0, 9, b"BBW", b"Baby whale", b"Baby whale on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e7b17f32-db02-425e-bd7d-2284eba5251c-blue-whale-with-white-nose-red-mouth_199644-19968.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBW>>(v1);
    }

    // decompiled from Move bytecode v6
}

