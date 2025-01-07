module 0xeb7d26373f6d6b0e0626b2a8385c62948f3c7e212cc8940b80425e00ae58a294::puss {
    struct PUSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUSS>(arg0, 9, b"PUSS", b"Pussy", b"Pussy cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cbff590d-4aa0-4e38-aea9-973a46cb93ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

