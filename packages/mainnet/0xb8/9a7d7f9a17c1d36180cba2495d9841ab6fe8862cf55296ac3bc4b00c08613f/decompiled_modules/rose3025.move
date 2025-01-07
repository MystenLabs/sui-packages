module 0xb89a7d7f9a17c1d36180cba2495d9841ab6fe8862cf55296ac3bc4b00c08613f::rose3025 {
    struct ROSE3025 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROSE3025, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROSE3025>(arg0, 9, b"ROSE3025", b"ROSE", b"LOVE ROSE=TAKE ROSE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9b5a7ead-27ea-4b2f-a2cf-e8fe03d61b37.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROSE3025>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROSE3025>>(v1);
    }

    // decompiled from Move bytecode v6
}

