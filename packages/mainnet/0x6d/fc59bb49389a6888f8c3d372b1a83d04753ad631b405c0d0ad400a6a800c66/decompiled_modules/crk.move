module 0x6dfc59bb49389a6888f8c3d372b1a83d04753ad631b405c0d0ad400a6a800c66::crk {
    struct CRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRK>(arg0, 6, b"CRK", b"CROAK", b"croak croak", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/croak_4cd1ab34aa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRK>>(v1);
    }

    // decompiled from Move bytecode v6
}

