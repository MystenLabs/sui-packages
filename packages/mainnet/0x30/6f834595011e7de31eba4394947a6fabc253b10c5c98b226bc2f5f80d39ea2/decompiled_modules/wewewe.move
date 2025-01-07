module 0x306f834595011e7de31eba4394947a6fabc253b10c5c98b226bc2f5f80d39ea2::wewewe {
    struct WEWEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWEWE>(arg0, 9, b"WEWEWE", b"Doge coi", b"Jxjxjjxnxnxjj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c1a92192-3134-4bad-aa25-e6a2e99fa44f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

