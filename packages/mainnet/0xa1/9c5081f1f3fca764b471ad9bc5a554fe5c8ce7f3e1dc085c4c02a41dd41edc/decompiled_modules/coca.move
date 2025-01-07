module 0xa19c5081f1f3fca764b471ad9bc5a554fe5c8ce7f3e1dc085c4c02a41dd41edc::coca {
    struct COCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCA>(arg0, 9, b"COCA", b"Woman", b"210000000", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eb0c158f-8ebb-4161-8a39-1d3ea841b760.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

