module 0x43014b37d691772d0731b9066a7e7d60d14cbaea43619ddcbacd9ec10fb6b1ff::mindchant {
    struct MINDCHANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINDCHANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINDCHANT>(arg0, 2, b"Mindchant", b"Mindchant", b"Mindchant is a meditation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MINDCHANT>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINDCHANT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINDCHANT>>(v1);
    }

    // decompiled from Move bytecode v6
}

