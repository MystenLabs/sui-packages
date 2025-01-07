module 0xdc520cbe80a3d0fbe958ba1b73aa436d90696eb41328f0e1a6ebbb242321bf83::foo {
    struct FOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOO>(arg0, 6, b"FOO", b"Foocat", b"Hello! Im FOOCAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_13_204438_51000dc26f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

