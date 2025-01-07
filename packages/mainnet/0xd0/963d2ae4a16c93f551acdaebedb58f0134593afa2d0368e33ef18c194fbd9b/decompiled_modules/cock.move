module 0xd0963d2ae4a16c93f551acdaebedb58f0134593afa2d0368e33ef18c194fbd9b::cock {
    struct COCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCK>(arg0, 6, b"COCK", b"Biggest $COCK on SUI", b"$COCK, just do it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_80b77acfc1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

