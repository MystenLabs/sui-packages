module 0x80859f5e2fe4eef28a2b59f5ac6cc22ab8b214f49272dd8a25c56f98200d06c8::ddf {
    struct DDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDF>(arg0, 9, b"DDF", b"DoDaFu", b"Nice token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/03fd07ad-4431-49a3-aa31-eb59e009a0b5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DDF>>(v1);
    }

    // decompiled from Move bytecode v6
}

