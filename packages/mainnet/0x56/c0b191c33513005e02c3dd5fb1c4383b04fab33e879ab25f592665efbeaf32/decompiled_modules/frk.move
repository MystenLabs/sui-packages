module 0x56c0b191c33513005e02c3dd5fb1c4383b04fab33e879ab25f592665efbeaf32::frk {
    struct FRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRK>(arg0, 9, b"FRK", b"Fork", b"it is not a normal fork it is a lovely fork buy it and try its magic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ac02ce67-7393-4655-afec-675be88a1311.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRK>>(v1);
    }

    // decompiled from Move bytecode v6
}

