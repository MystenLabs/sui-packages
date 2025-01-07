module 0xa90d7a73d9089d19c89fc98557ed15e1d0934d2b2d7d5d214e7501e10d6a6530::wau {
    struct WAU has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAU>(arg0, 9, b"WAU", b"WAU TOKEN", b"WAU IS SUI THE TOO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f0b92330-f82a-4ebf-b9e6-aaedd86693e1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAU>>(v1);
    }

    // decompiled from Move bytecode v6
}

