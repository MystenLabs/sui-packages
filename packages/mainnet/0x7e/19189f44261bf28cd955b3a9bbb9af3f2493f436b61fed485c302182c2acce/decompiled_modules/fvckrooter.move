module 0x7e19189f44261bf28cd955b3a9bbb9af3f2493f436b61fed485c302182c2acce::fvckrooter {
    struct FVCKROOTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FVCKROOTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FVCKROOTER>(arg0, 9, b"FVCKROOTER", b"FVCK ROOTER", b"FVCK ROOTER THE REAL SCAMMER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FVCKROOTER>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FVCKROOTER>>(v2, @0x940a52d4dff229e118f3ecfe78f9713b651490f024f02eb9756d2be3477614dd);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FVCKROOTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

