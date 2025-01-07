module 0xd312751b18f1feac15e67cb3b9fcd2029fecb455a70f39a6e824d5da41fef309::angry {
    struct ANGRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANGRY>(arg0, 9, b"ANGRY", b"ANGRYBIRDS", b"Birds are usually seen as tiny creatures that tweets sweet sounds and put a smile on our faces when they fly around with their colourful feathers, what happens when they are angry?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/de6ddf5c-533e-453f-a6b3-38e6f49634b9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANGRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANGRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

