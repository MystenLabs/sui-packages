module 0xf42d5e12b8c36d4809061da6082a1a601c395e0562bc6fda725715513aed73fe::ltli {
    struct LTLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LTLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LTLI>(arg0, 9, b"LTLI", b"LITTELE", b"LIttle gazelle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/582ff022-bcab-4156-b8cf-fe55904fb836.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LTLI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LTLI>>(v1);
    }

    // decompiled from Move bytecode v6
}

