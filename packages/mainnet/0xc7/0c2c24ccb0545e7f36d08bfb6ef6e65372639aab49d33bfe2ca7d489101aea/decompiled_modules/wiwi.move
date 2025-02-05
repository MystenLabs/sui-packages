module 0xc70c2c24ccb0545e7f36d08bfb6ef6e65372639aab49d33bfe2ca7d489101aea::wiwi {
    struct WIWI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIWI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIWI>(arg0, 9, b"WIWI", b"WIWI AI", b"WIWI Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a18369be-4d39-48cb-83b3-79f351fa37cc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIWI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIWI>>(v1);
    }

    // decompiled from Move bytecode v6
}

