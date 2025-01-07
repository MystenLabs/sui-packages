module 0x198d9f35d66c82581aa7a5534f1d40180d5f35ae7bdf969dc7b86709b2b99891::ld {
    struct LD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LD>(arg0, 9, b"LD", b"LIZARD", x"49e280996d206c697a61726420f09fa68e202074686174206361726520666f722074686520636f6d6d756e697479", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c5c3489b-a538-473d-9e08-7aa75a6ed842.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LD>>(v1);
    }

    // decompiled from Move bytecode v6
}

