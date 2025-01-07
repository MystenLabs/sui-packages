module 0xdf47c6f5ee3c0011493a4675062338c3438d832522411c37a744cdb0c44c52a0::tw {
    struct TW has drop {
        dummy_field: bool,
    }

    fun init(arg0: TW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TW>(arg0, 9, b"TW", b"TrumpWIn", b"Trump win celeration", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cefe7db8-f2e3-4f28-ae3e-52bcfdc6c67c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TW>>(v1);
    }

    // decompiled from Move bytecode v6
}

