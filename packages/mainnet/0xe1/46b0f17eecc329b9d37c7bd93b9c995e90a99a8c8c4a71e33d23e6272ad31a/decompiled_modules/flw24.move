module 0xe146b0f17eecc329b9d37c7bd93b9c995e90a99a8c8c4a71e33d23e6272ad31a::flw24 {
    struct FLW24 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLW24, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLW24>(arg0, 9, b"FLW24", b"Flow24", b"Move with the flow, never try to disrupt the wave.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7fb47c63-3327-4a00-91e0-51f2a8856cdb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLW24>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLW24>>(v1);
    }

    // decompiled from Move bytecode v6
}

