module 0x3222458e647ba3b63395c4608ffae55f59c34fd7613eee9d8c2d7fb9544aaa17::spad {
    struct SPAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPAD>(arg0, 6, b"SPad", b"SuiPad", x"57656c636f6d6520546f20537569506164202d204c61756e6368706164204f66205375690a0a53756950616420497320616e206170706c69636174696f6e20746861742068656c70732070656f706c6520746f206c61756e636820656173696c79206c696b65206d6f766570756d700a0a4f7572207072696f7269747920697320746865207365637572697479206f6620686f6c646572732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241005_141123_878_a7b2d41c13.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

