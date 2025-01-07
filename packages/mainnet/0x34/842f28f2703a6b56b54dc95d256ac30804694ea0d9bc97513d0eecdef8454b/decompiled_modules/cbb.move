module 0x34842f28f2703a6b56b54dc95d256ac30804694ea0d9bc97513d0eecdef8454b::cbb {
    struct CBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CBB>(arg0, 9, b"CBB", b"cBABA", b"Fun coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/90fe8a0d-422f-461a-8220-5ad5b1ea6858.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CBB>>(v1);
    }

    // decompiled from Move bytecode v6
}

