module 0x5bab3da55c56bde067b918736f736bbb277e98ed143f070655f7393e32011a95::ygs {
    struct YGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: YGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YGS>(arg0, 6, b"YGS", b"YELLOW GROUPER", x"444f4e542042555920204a757374206a6f696e206f757220636f6d6d756e697479200a5745204c4f554e43482041465445522035304d454d4245525447", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_11_27_at_23_08_12_c2d53b8c_3a40a7c052.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

