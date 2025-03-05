module 0x3484bc72bd05a7715fb19b7a195882c0b02c23a7b0b9f4136972ff7fd1f27c32::anim {
    struct ANIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANIM>(arg0, 9, b"ANIM", b"AnimCoin", b"A token for the Anim ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ANIM>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANIM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

