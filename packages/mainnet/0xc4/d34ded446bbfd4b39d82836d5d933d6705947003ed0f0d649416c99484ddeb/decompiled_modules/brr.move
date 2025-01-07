module 0xc4d34ded446bbfd4b39d82836d5d933d6705947003ed0f0d649416c99484ddeb::brr {
    struct BRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRR>(arg0, 9, b"BRR", b"Brutal rat", b"Together in the Moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6266d87f-f9c6-4525-a944-44c2c06600a6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRR>>(v1);
    }

    // decompiled from Move bytecode v6
}

