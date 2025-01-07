module 0xd1a9bca9c714f7ceecb233893aa595ab29b40753ddbe017afae937fdaeb72f51::spiro {
    struct SPIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPIRO>(arg0, 6, b"SPIRO", b"SUIPIRO", x"5049524f2061206c696c20616c69656e2063726561746564206279204d6174742046757269652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f26_YI_Px_Q_400x400_2b5a30b2b2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

