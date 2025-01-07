module 0x3e8f27e7063b86e717a095b2bd676689116e8aefd9d5f8319a013453a7e6ca2c::tvt0x06c81 {
    struct TVT0X06C81 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TVT0X06C81, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TVT0X06C81>(arg0, 9, b"TVT0X06C81", b"TAN", b"This coin is very valuable in the future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/60ede8e5-9bac-4a32-8fbd-fcb6eceb97e0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TVT0X06C81>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TVT0X06C81>>(v1);
    }

    // decompiled from Move bytecode v6
}

