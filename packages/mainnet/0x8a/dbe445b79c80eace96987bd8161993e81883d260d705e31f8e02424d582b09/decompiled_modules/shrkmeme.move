module 0x8adbe445b79c80eace96987bd8161993e81883d260d705e31f8e02424d582b09::shrkmeme {
    struct SHRKMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRKMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRKMEME>(arg0, 9, b"SHRKMEME", b"SHARKMEME", b"sharks will become wild BECAUSE OF YOU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/de4dd741-ec4a-47bb-875f-d338547e5cbd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRKMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHRKMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

