module 0x4030438fcde6cf14f67b689cb494c3b269e23ae1c54d7d7687b6ff303194d9e3::sda {
    struct SDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDA>(arg0, 9, b"SDA", b"Sidra", b"developed by Mohammed Hassan Al-Jefairi, an entrepreneur and book author known as MJ. MJ is also the founder of Sidra Bank, the world's first decentralized Islamic digital bank.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1a7e84ef-c01c-4798-aa7a-26d81ac7eb31.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

