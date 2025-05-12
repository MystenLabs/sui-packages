module 0x2c56235705e1f77c85521d7e71ff2391952a407e40f62be5f44e0721daf77b40::bd {
    struct BD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BD>(arg0, 1, b"BD", b"Bts$", b"Bts$ hai Super Dubai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/1f5d5c10-2ef6-11f0-852e-3585a1f35c1e")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BD>>(v1);
        0x2::coin::mint_and_transfer<BD>(&mut v2, 11000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BD>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

