module 0xfd3c1a8a787a8749c12af1dc998eaf1d8ee87be456a32ecb09fd4996d334bcb9::memtoken {
    struct MEMTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMTOKEN>(arg0, 9, b"MEMTOKEN", b"STM ", b"STM MEMTOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ea70b920-64fa-404b-ae86-9b90f3064a00.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMTOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMTOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

