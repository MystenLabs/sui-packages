module 0xae9b076408a6444ef703af9fd47c7e0622f72a6b9ee23554b62574184fd56d1e::suiscan {
    struct SUISCAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISCAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISCAN>(arg0, 9, b"SUISCAN", b"SUISCAN", b"SUISCAN Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUISCAN>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISCAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISCAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

