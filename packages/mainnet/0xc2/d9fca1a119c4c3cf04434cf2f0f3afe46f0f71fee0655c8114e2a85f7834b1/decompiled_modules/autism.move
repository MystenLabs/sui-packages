module 0xc2d9fca1a119c4c3cf04434cf2f0f3afe46f0f71fee0655c8114e2a85f7834b1::autism {
    struct AUTISM has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUTISM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUTISM>(arg0, 6, b"AUTISM", b"AutismOnSui", b"Please be patient i have autism $AUTISM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000140_499408013f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUTISM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AUTISM>>(v1);
    }

    // decompiled from Move bytecode v6
}

