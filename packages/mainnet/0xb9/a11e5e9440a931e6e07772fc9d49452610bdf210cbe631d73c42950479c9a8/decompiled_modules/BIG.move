module 0xb9a11e5e9440a931e6e07772fc9d49452610bdf210cbe631d73c42950479c9a8::BIG {
    struct BIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIG>(arg0, 9, b"BIG", b"BIG", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIG>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BIG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<BIG>>(0x2::coin::mint<BIG>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

