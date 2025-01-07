module 0xc486bfc2a763885b4cb59e78c7d5af084545afa2bd19abf4d1369b18989593d6::ha {
    struct HA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HA>(arg0, 9, b"HA", b"HAP", b"HAP IS A BULL RUN TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d5bcab01-1656-4151-a013-7ffbc824abc5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HA>>(v1);
    }

    // decompiled from Move bytecode v6
}

