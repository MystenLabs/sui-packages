module 0xcf9fc546886db4c00958f7dd7a71a2abfca7dcdf291629c26a0913af54dd0580::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0946495348494e53554909e9b1bce5be97e6b0b48e0222e5a682e9b1bce5be97e6b0b4e2809ce698afe4b880e4b8aae4b8ade59bbde68890e8afadefbc8ce6848fe6809de698afe689bee588b0e4ba86e98082e59088e887aae5b7b1e58f91e5b195e79a84e78eafe5a283efbc8ce4bb8ee8808ce883bde58585e58886e696bde5b195e6898de883bde38081e6849fe588b0e99d9ee5b8b8e887aae59ca8e5928ce79585e5bfabe38082e694b9e68890e2809de9b1bce5be97e6b0b4e2809ce6848fe6809de4b880e6a0b7efbc8ce69bb4e98082e590884d454d45e3808220e999a4e4ba86e683b3e587bae8bf99e4b8aae697a0e58e98e5a4b4e79a84e5908de5ad97e5a496efbc8ce588abe697a0e585b6e4bb96e380824a555354204c494b45efbc812068747470733a2f2f692e696d6775722e636f6d2f4b6f69704259412e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

