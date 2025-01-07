module 0x9a862937b9a8014b4fa5215522f9b675953307db02631f0c641d171efebbf0::benni {
    struct BENNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENNI>(arg0, 6, b"BENNI", b"bennionsui", x"0a68747470733a2f2f62656e69746865646f672e78797a2f0a0a68747470733a2f2f782e636f6d2f62656e696f6e7375690a0a68747470733a2f2f742e6d652f62656e696f6e7375690a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/u_Mq_TW_Ho_F_400x400_dedcae37f3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENNI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENNI>>(v1);
    }

    // decompiled from Move bytecode v6
}

