module 0x450c0b053657d2c1ca621209611381099bed813ca4e242b0aa1f32f683af29e0::babyhippo {
    struct BABYHIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYHIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYHIPPO>(arg0, 6, b"BabyHippo", b"BabyHIPPO", x"536c65656b2c20626f6c642c20616e6420756e666f726765747461626c652042616279486970706f206973206d616b696e6720697473206d61726b206f6e205355490a0a4920666f72676f7421205468652063617027732020626563617573652049276d2062616c64", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4a6ef6d9_d9c5_433c_9d8a_c264ff626e8d_ezgif_com_optimize_2370bd3698.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYHIPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYHIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

