module 0xce904ecbc46f518a180ac73a8266366e1fa4746c536e9c778c3ef722a3784c0::gm {
    struct GM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GM>(arg0, 6, b"GM", b"Good Morning Cat", b"GM's fair relaunch on the superior SUI chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/G_Svggv_Xw_AA_Wv_Tf_80638706a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GM>>(v1);
    }

    // decompiled from Move bytecode v6
}

