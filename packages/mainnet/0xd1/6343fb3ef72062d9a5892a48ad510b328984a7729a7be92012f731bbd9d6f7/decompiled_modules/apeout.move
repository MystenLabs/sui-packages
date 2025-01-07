module 0xd16343fb3ef72062d9a5892a48ad510b328984a7729a7be92012f731bbd9d6f7::apeout {
    struct APEOUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: APEOUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APEOUT>(arg0, 6, b"APEOUT", b"Apeout SUI", x"4170654f75743a2053776966742045786974205374726174656779204175746f204170696e6720426f7420666f722043727970746f20547261646572730a2d2064657369676e656420666f722063727970746f20747261646572732077686f206e65656420746f20717569636b6c792022617065206f757422206f6620746865697220746f6b656e20706f736974696f6e732c20657370656369616c6c7920696e2074686520766f6c6174696c6520776f726c64206f66206d656d65636f696e7320616e642070756d702d616e642d64756d7020736368656d65732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241229_052211_175_8ff6569172.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APEOUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APEOUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

