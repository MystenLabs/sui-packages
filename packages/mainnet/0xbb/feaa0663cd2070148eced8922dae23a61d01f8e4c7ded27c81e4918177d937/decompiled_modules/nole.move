module 0xbbfeaa0663cd2070148eced8922dae23a61d01f8e4c7ded27c81e4918177d937::nole {
    struct NOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOLE>(arg0, 1, b"Nole", b"NOLE", b"Novak.fan.token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/990e0df0-de80-11ef-8055-0d7cc78361d5")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOLE>>(v1);
        0x2::coin::mint_and_transfer<NOLE>(&mut v2, 11000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOLE>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

