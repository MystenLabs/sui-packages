module 0xc77d1f83cf098668eef0e1572024e5f77636b35b2e3cd6fa81e6773863399b70::neirasui {
    struct NEIRASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIRASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIRASUI>(arg0, 6, b"NEIRASUI", b"NEIRA SUI", b"Get ready, crypto enthusiasts! $NEIRA is dropping on the SUI network, and its about to take your meme game to a whole new level.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/91acbe80_c5eb_4298_8885_5c882700a7cc_31fedf7309.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIRASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIRASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

