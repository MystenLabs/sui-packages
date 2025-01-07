module 0x19a50ad37b3bd1bfdc3fc06c21f8e3f68928173558ccab114891381e12409754::hjkhbnjj {
    struct HJKHBNJJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: HJKHBNJJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HJKHBNJJ>(arg0, 9, b"HJKHBNJJ", b"Hkjvjbnnnm", b"Hnkpbjb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/974659a4-a8cd-4a96-b462-92cf30a83f0a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HJKHBNJJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HJKHBNJJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

