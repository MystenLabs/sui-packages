module 0xa179cb04cc1387a48da95367e0828efe4b1df0dfa768b904f4a62f6e3e54fd8a::plop {
    struct PLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLOP>(arg0, 6, b"PLOP", b"$PLOP", x"506c6f70206973206865726520746f20706c6f7020706c6f702053554920636861696e2c2062757920756e64657220796f7572206f776e207269736b732c20776520617265206d656d6520636f696e207769746820746865206f6e6c7920676f616c206f6620637265617465206120636f6d6d756e6974792061726f756e642053554920616e6420506c6f702120456e6a6f792c20686176652066756e20616e642063726561746520796f7572206265737420706c6f7021204d6f737420726174656420706c6f70732077696c6c2062652070617274206f66207468697320776562736974652c2063726561746520796f757220506c6f70206e6f77210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_logo_53deaa7ecf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

