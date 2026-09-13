module 0xfa09c3d75760c671fc2b7ff4a9a52679d3c445283548467ae92f8a66fb3b7c40::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0753554942554c4c082453756962756c6cb101426f726e20696e2074686520537569207472656e636865732c20245355492042554c4c206973206120636f6d6d756e6974792d64726976656e206d656d6520636f696e206675656c6564206279206d656d65732c206368616f7320616e64207075726520646567656e20636f6e76696374696f6e2e204e6f2066616b652070726f6d697365732e204e6f20636f6d706c696361746564207574696c6974792e204a7573742053756920656e65726779202b80013c6120687265663d2268747470733a2f2f6962622e636f2f62676a3352715152223e3c696d67207372633d2268747470733a2f2f692e6962622e636f2f643073634a316a4a2f5355492d42554c4c2d69636f6e2d322e706e672220616c743d225355492042554c4c2069636f6e20322220626f726465723d2230223e3c2f613e");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

