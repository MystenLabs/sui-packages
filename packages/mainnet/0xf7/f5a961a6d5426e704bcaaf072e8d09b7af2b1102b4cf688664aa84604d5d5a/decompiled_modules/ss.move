module 0xf7f5a961a6d5426e704bcaaf072e8d09b7af2b1102b4cf688664aa84604d5d5a::ss {
    struct SS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SS>(arg0, 6, b"SS", b"Suisinu", x"53554920494e55202d20576174657220646f67200a0a5375692069732077617465722c20696e7520697320646f6720616e6420776174657220646f6720697320676f696e6720746f206265207468652062657374206d656d65206f6620535549200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000036068_3048054f1b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SS>>(v1);
    }

    // decompiled from Move bytecode v6
}

