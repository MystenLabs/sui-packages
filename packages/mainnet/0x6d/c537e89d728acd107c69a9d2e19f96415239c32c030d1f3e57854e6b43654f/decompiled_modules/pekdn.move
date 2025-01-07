module 0x6dc537e89d728acd107c69a9d2e19f96415239c32c030d1f3e57854e6b43654f::pekdn {
    struct PEKDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEKDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEKDN>(arg0, 9, b"PEKDN", b"hseike", b"brbdb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b9bdfc9f-9535-4ffd-929f-843ad9ccfed5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEKDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEKDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

