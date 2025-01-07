module 0x1dfff654ec2d1aec0c66e5a4c970c1b2bc77970599908cc6da0a7f22b217666c::woofie {
    struct WOOFIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOFIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOFIE>(arg0, 6, b"WOOFIE", b"WOOFIE on Sui", x"496e74726f647563696e6720576f6f6669653a20616e20656c6567616e74206d656d6520636f696e206f6e2074686520536f6c616e61206e6574776f726b2e20436f6d62696e696e672074686520706c617966756c20636861726d206f662061206c6f79616c20636f6d70616e696f6e20776974682074686520737065656420616e6420656666696369656e6379206f6620536f6c616e612c20576f6f6669652061646473206120746f756368206f6620736f706869737469636174696f6e20746f207468652063727970746f20776f726c642e20496e76657374207769746820636c6173732c206a6f696e2074686520576f6f666965207061636b20746f646179210a496d6167650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7x_LWR_6_Tqnog2_Ahb7_V_Vr7wz1wseze142m_Xkv_Cc_F7spump_1a9e54ba3e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOFIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOOFIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

