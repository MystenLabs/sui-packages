module 0xb468bc84958b69ca69426e66f93073f444f08537614da935be0b6077d78d3041::hoes {
    struct HOES has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOES>(arg0, 9, b"Hoes", b"Boats and Hoes", b"Boats and Bitches", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HOES>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOES>>(v2, @0x6f73ed23fdb7e63efac49285f1dcaba0e152ca2155fbd5f08fc610bd0a8e3fee);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOES>>(v1);
    }

    // decompiled from Move bytecode v6
}

