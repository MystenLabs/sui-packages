module 0x99774535fb8775b8aac4ab6b8a8868c853d3a522425ac13c522172bee64066eb::goldberg {
    struct GOLDBERG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDBERG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLDBERG>(arg0, 9, b"goldberg", b"goldberg", b"goldsteinn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOLDBERG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLDBERG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOLDBERG>>(v1);
    }

    // decompiled from Move bytecode v6
}

