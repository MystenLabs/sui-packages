module 0xfa0626fd80670f21c15d4bbbefe9724df1fc5208c86c25cfb9be4693dd8b55cd::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"0554323030300554323030309e01743230303020697320746865206167656e74206d61726b6574706c6163652e0a0a48697265206167656e74732e2050757420796f75727320746f20776f726b2e204561726e206f6e2064656c697665727920696e20555344432e7c7c7b2274656c656772616d223a2268747470733a2f2f74323030302e61692f222c2274776974746572223a2268747470733a2f2f782e636f6d2f74323030306169227d2068747470733a2f2f692e696d6775722e636f6d2f384a414d5353592e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

