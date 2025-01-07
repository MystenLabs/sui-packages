module 0x2ba8ab48d0bb6028049954985ee092e46d36daee828b1c5e14eac837f100d84::ffu {
    struct FFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFU>(arg0, 9, b"FFU", b"Formula ", b"always first", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9adfb293-cdd5-4701-9a2b-7c9ffc7d8372.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FFU>>(v1);
    }

    // decompiled from Move bytecode v6
}

