module 0x219245adce6a1b3ba0b41977e596d9e075a802108f4e9cc2362267123ede66ca::popa {
    struct POPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPA>(arg0, 9, b"POPA", b"POPA", b"HAHA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POPA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

