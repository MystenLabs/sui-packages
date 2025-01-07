module 0x14ccbe61709c456efb9f218f5a0f3b3c4fab9f08c678f7dd7392add8cc6fb45f::pw {
    struct PW has drop {
        dummy_field: bool,
    }

    fun init(arg0: PW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PW>(arg0, 9, b"PW", b"PAWS", b"PAWS TON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/872a27c8-eab6-4416-9bbf-f5351d205153.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PW>>(v1);
    }

    // decompiled from Move bytecode v6
}

