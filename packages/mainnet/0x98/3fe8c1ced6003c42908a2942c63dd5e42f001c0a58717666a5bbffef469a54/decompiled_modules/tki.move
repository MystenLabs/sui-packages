module 0x983fe8c1ced6003c42908a2942c63dd5e42f001c0a58717666a5bbffef469a54::tki {
    struct TKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TKI>(arg0, 9, b"TKI", b"Tokifi", x"546f4b6946692028544b4929200a0a54686520556c74696d6174652043727970746f20526166666c6520506c6174666f726d204275696c74206f6e205355492c20546f4b694669206272696e677320746865206578636974656d656e74206f66205257412c204e4654732c20616e642074686520535549204a61636b706f74204c6f7474657279e28094616c6c20757020666f7220677261627321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://blob.suiget.xyz/uploads/img_67c8c261609fe6.63620796.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

