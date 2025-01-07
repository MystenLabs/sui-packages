module 0xb13b57b7a2378a7f1a987a46cbe126986e7b418e906e943b0dbc9eee54145d5e::rwer {
    struct RWER has drop {
        dummy_field: bool,
    }

    fun init(arg0: RWER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RWER>(arg0, 1, b"rwer", b"werwe", b"rr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RWER>(&mut v2, 333333333330, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RWER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RWER>>(v1);
    }

    // decompiled from Move bytecode v6
}

