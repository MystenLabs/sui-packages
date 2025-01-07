module 0x3634ebdec0bd759e569a4bb1d9e4bafc2b4793619cb02f995278dfc8f5eab3ff::GAY {
    struct GAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAY>(arg0, 9, b"GAY", b"GAY", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0jjIEXv-70vvHa7ZTdaMLQeF4w5FQkpwANg&s")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAY>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GAY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<GAY>>(0x2::coin::mint<GAY>(&mut v2, 4000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

