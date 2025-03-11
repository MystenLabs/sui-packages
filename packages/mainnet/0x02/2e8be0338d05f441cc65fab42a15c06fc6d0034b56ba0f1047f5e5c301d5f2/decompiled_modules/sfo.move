module 0x22e8be0338d05f441cc65fab42a15c06fc6d0034b56ba0f1047f5e5c301d5f2::sfo {
    struct SFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFO>(arg0, 9, b"sfo", b"SFO", b"A sample token named SFO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SFO>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFO>>(v1);
    }

    // decompiled from Move bytecode v6
}

