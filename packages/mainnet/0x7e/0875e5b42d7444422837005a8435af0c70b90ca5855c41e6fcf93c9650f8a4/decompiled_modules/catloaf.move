module 0x7e0875e5b42d7444422837005a8435af0c70b90ca5855c41e6fcf93c9650f8a4::catloaf {
    struct CATLOAF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATLOAF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATLOAF>(arg0, 6, b"CATLOAF", b"Catloaf", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.catloafsoft.com/img/catloaf.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CATLOAF>(&mut v2, 555555555000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATLOAF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATLOAF>>(v1);
    }

    // decompiled from Move bytecode v6
}

