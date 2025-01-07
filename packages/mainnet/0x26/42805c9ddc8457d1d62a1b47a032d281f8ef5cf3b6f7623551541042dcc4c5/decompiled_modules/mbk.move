module 0x2642805c9ddc8457d1d62a1b47a032d281f8ef5cf3b6f7623551541042dcc4c5::mbk {
    struct MBK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBK>(arg0, 6, b"MBK", b"Bucks", x"4d454d45204275636b732028244d424b29202d2054686520556c74696d617465204d656d6520436f696e205265766f6c7574696f6e200a57656c636f6d6520746f204d454d45204275636b732028244d424b292c20746865206d6f7374206578636974696e6720616e642068696c6172696f7573206d656d6520636f696e206f6e2074686520626c6f636b636861696e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1724109494761_77e400a0ce1e6973fb927e39ebe27d4b_cc13e8ad43.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MBK>>(v1);
    }

    // decompiled from Move bytecode v6
}

