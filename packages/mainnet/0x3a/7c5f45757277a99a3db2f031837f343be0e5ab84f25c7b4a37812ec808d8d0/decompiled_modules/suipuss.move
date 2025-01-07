module 0x3a7c5f45757277a99a3db2f031837f343be0e5ab84f25c7b4a37812ec808d8d0::suipuss {
    struct SUIPUSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPUSS>(arg0, 6, b"SUIPUSS", b"Sui Puss", x"245355495055535320697320746865206669727374206d656d65636f696e2066726f6d206f6e65206f6620746865206c61726765737420626c6f636b636861696e2d626173656420736f6369616c206d6564696120706c6174666f726d732c20537465656d69742e200a0a576562736974653a2068747470733a2f2f707573732e6d656d650a0a526f61646d61703a204445582c204e46542c2047616d6573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_R9j03dm_400x400_9ebfae0817.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

