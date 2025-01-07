module 0xeb2a11c3ac8ef05a8677dab652d465e4d33a883e384bbc94454eae8953009523::wasn {
    struct WASN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WASN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WASN>(arg0, 9, b"WASN", b"WILD ASSN", b"WILEST ASSASSIN EVER , BEST TOKEN EVER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9deb9687-e3c1-47ab-93fc-78c81447bf7a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WASN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WASN>>(v1);
    }

    // decompiled from Move bytecode v6
}

