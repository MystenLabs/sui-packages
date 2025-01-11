module 0x12f7672bad1440b94ed035b6b0c21f258ea47221b65bb462ac58d23c54a1756f::ius {
    struct IUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IUS>(arg0, 6, b"IUS", b"IUS reversed SUI", x"2449555320e2809320546865204d656d6520436f696e2054686174205475726e73205355492055707369646520446f776e20f09f9a80f09f8ead0a0a2449555320697320696e7370697265642062792069747320717569726b7920726576657273652074616b65206f6e205355492c2024495553206272696e67732061206672657368207370696e20746f20746865206d656d6520636f696e20756e6976657273652e200a0a576974682068756d6f7220696e2069747320444e4120616e6420696e6e6f766174696f6e20696e2069747320636f6465", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736617404954.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

