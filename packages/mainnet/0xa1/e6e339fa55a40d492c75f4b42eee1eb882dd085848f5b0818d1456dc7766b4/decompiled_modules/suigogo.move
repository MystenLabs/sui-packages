module 0xa1e6e339fa55a40d492c75f4b42eee1eb882dd085848f5b0818d1456dc7766b4::suigogo {
    struct SUIGOGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGOGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGOGO>(arg0, 9, b"SUIGOGO", x"f09f90b1537569676f676f", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIGOGO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGOGO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGOGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

