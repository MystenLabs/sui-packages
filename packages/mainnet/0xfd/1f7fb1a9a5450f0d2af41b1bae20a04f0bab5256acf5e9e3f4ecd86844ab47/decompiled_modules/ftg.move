module 0xfd1f7fb1a9a5450f0d2af41b1bae20a04f0bab5256acf5e9e3f4ecd86844ab47::ftg {
    struct FTG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FTG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FTG>(arg0, 9, b"FTG", b"Fighting", b"Fighting meme coin fore the wave community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7d12bc16-4b91-4969-bc10-ab2da312f574.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FTG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FTG>>(v1);
    }

    // decompiled from Move bytecode v6
}

