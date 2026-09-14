module 0xf798596a58cdaa1c0f92eb6796c740b5be5513b04d9119737ea92291d0fede3b::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"07425546465355490a42756666616c6f7375690c69206d697373206865722e2e840168747470733a2f2f706e672e706e67747265652e636f6d2f706e672d766563746f722f32303234303732332f6f75726d69642f706e67747265652d62656173742d6176617461722d6e66742d636172746f6f6e2d6368617261637465722d6d6f6e737465722d6869702d686f702d706e672d696d6167655f31333034313838302e706e67");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

