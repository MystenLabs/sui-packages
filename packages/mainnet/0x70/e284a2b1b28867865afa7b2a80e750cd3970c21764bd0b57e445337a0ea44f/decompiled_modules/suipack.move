module 0x70e284a2b1b28867865afa7b2a80e750cd3970c21764bd0b57e445337a0ea44f::suipack {
    struct SUIPACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPACK>(arg0, 6, b"SUIPACK", b"SUI PACK", x"416c72696768742c20736f20245355495041434b206a757374206b696e6461e280a620666c6f6174696e672061726f756e642c20646f696e6720697473207468696e672c206368696c6c696ee28099206c696b652061206c617a79206379616e206475636b206f6e20612063616c6d20706f6e642e204e6f20727573682c206e6f20737472657373e280946a75737420717561636b696e6720616e6420737461636b696e672074686f7365206761696e7320776974686f7574206576656e20747279696e672e204974e2809973206e6f74206865726520746f20737072696e742c206a75737420746f20676c69646520616e642076696265207768696c65206c6574", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731137326130.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPACK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPACK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

