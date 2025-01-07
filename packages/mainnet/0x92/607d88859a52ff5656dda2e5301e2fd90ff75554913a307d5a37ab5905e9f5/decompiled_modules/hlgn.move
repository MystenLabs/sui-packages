module 0x92607d88859a52ff5656dda2e5301e2fd90ff75554913a307d5a37ab5905e9f5::hlgn {
    struct HLGN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HLGN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HLGN>(arg0, 9, b"HLGN", x"d0a5d183d0bbd0b82dd093d0b0d0bdd18b", x"d09fd0bed0bad183d0bfd0b0d0b5d0bc202d20d0bdd0b520d0bfd180d0bed0b4d0b0d0b5d0bc202120d0a5d0bed0bbd0b420d0a2d0b8d0bcd0b021", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/018c3633-07c4-4041-9ba6-5f1fdfe23a78-IMG_5067.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HLGN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HLGN>>(v1);
    }

    // decompiled from Move bytecode v6
}

