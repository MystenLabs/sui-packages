module 0xab482706a1d9da3a99ae4ccaf79b3c8e31f182ae91069e746dd13b593d341bf5::momocoin {
    struct MOMOCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOMOCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOMOCOIN>(arg0, 9, b"MOMOCOIN", b"MOMO", b"Tip coin momo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bf842e03-6415-4e24-a231-a69d9b06fcca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOMOCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOMOCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

