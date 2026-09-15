module 0xe186ba370df31827bbaea8899ccaeb261a2a4f4b723ac97e02a47d2411ae2b8c::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"044a4f4646044a6f6666b301322053554920c2b72066616972206c61756e636820c2b7206e6f207072652d6d696e6520c2b720314220737570706c792c203830304d206f6e207468652063757276657c7c7b2274656c656772616d223a2268747470733a2f2f742e6d652f6a6f6666706f7274616c222c2274776974746572223a2268747470733a2f2f782e636f6d2f6a6f66665f686c222c2277656273697465223a2268747470733a2f2f7777772e6a6f66666f6e686c2e78797a2f227d6c68747470733a2f2f63646e2e64657873637265656e65722e636f6d2f636d732f696d616765732f5845386d494f31436c725637647551413f77696474683d313238266865696768743d313238266669743d63726f70267175616c6974793d393526666f726d61743d6175746f");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

