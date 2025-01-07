module 0x378a20eb9ab2e701080f6034383e4cd7fe4fc0b2c6f200d1075de4c2661d12f2::notmeme {
    struct NOTMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTMEME>(arg0, 9, b"NOTMEME", b"ItsNoAMEME", b"MEMEMEMEMEMEMEMEMEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHxlqnONy3SQT_yRfB_TNoobZlWKslobvNnaGssyqJ-4DgWG9bF-qDfKFcEhJF_nheePQ&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NOTMEME>(&mut v2, 11111111111000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTMEME>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOTMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

