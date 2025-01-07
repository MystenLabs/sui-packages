module 0xf0ded5b12c3c5bd3227ce3ab05aba974f37f7184ace74f80c496c85133708e8e::swh {
    struct SWH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWH>(arg0, 9, b"SWH", b"suiman wif hat", b"the suiman wif hat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SWH>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWH>>(v1);
    }

    // decompiled from Move bytecode v6
}

