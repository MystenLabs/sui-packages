module 0x27fa5dd41405a6f7148f79c08b714c16d0ae75c0e07dd9538f85d0ef8401750a::ld {
    struct LD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LD>(arg0, 9, b"LD", b"LIZARD", x"49e280996d206c697a61726420f09fa68e202074686174206361726520666f722074686520636f6d6d756e697479", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/de8ee6ea-a020-491b-bb90-c97e1c42e8b9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LD>>(v1);
    }

    // decompiled from Move bytecode v6
}

