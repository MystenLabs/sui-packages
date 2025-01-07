module 0xdf74b412322c80bfe8e661f2429fba8fa511cad1a4a03284d038786a523e1c58::mao {
    struct MAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAO>(arg0, 6, b"MAO", b"MAOonSui", x"666f7220736f6d6520726561736f6e2061206c6f74206f662070656f706c65207374617274656420666f6c6c6f77696e67206d79205820726563656e746c792e207768747665722e0a0a696d20686f6e6f72656420627574207965616820677579732069206469646e742061736b20746f2062652066616d6f75732e206b696e646120616e6e6f79696e672e0a0a73686f75746f757420746f206d79206c6f79616c20666f6c6c6f776572732074686f756768207765726520707265747479207469676874206b6e6974", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/qy53_Wup8_400x400_4b4e98a2d7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

