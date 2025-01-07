module 0x2ba0bb263726130f6013c329066c2bb53bc2b7166fb9c15fbc9d722803cc9205::wave07 {
    struct WAVE07 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVE07, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVE07>(arg0, 9, b"WAVE07", b"WAVE TOKEN", b"COLOURFUL WAVES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/830cf448-0706-4756-b5d1-63860597e3c5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVE07>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVE07>>(v1);
    }

    // decompiled from Move bytecode v6
}

