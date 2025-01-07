module 0xac121a068d0be3792a6e168519b410a4eb8be64307bb7e6e2cb6b29c83195f5b::mentor452 {
    struct MENTOR452 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MENTOR452, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MENTOR452>(arg0, 9, b"MENTOR452", b"HONRA", b"Simplicity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/93c92379-a8ae-43f6-99cf-40ad9d702783.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MENTOR452>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MENTOR452>>(v1);
    }

    // decompiled from Move bytecode v6
}

