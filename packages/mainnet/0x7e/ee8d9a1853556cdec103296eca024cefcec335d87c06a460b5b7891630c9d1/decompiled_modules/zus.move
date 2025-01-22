module 0x7eee8d9a1853556cdec103296eca024cefcec335d87c06a460b5b7891630c9d1::zus {
    struct ZUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUS>(arg0, 4, b"ZUS", b"Zustand 1", b"Zustand test 1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/3892c9a0-d897-11ef-9ad1-d96ea2b1225f")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZUS>>(v1);
        0x2::coin::mint_and_transfer<ZUS>(&mut v2, 11000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUS>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

