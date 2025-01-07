module 0x7b5c4b78c9c1db8da999ea8928b753743d108bc578e56c2d10560da17c1206e7::cr777 {
    struct CR777 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CR777, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CR777>(arg0, 9, b"CR777", b"Cr7", b"Butyyyyy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ee49a194-9e62-426e-8162-0e66a4d6a487.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CR777>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CR777>>(v1);
    }

    // decompiled from Move bytecode v6
}

