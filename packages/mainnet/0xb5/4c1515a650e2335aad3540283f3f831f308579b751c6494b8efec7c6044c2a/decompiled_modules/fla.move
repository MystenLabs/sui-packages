module 0xb54c1515a650e2335aad3540283f3f831f308579b751c6494b8efec7c6044c2a::fla {
    struct FLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLA>(arg0, 9, b"FLA", b"Flamingo", b"FLAMINGO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3e5f96f8-8164-4df9-b9e4-bd918d71cc54.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

