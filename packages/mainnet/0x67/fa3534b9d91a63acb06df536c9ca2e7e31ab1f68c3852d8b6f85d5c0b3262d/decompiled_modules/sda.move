module 0x67fa3534b9d91a63acb06df536c9ca2e7e31ab1f68c3852d8b6f85d5c0b3262d::sda {
    struct SDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDA>(arg0, 9, b"SDA", b"Sidra", b"developed by Mohammed Hassan Al-Jefairi, an entrepreneur and book author known as MJ. MJ is also the founder of Sidra Bank, the world's first decentralized Islamic digital bank.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2303aa12-12bc-41b4-ba71-9e7d7329bfd3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

