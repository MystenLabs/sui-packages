module 0xf90e7eccbcbbba17611df2ac48a9aa74abbe729a20fb2ecbebef9097b3b8cde0::jso {
    struct JSO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JSO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JSO>(arg0, 6, b"JSO", b"J-BlackPink", b"like", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jisoo_5b46b7ea17.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JSO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JSO>>(v1);
    }

    // decompiled from Move bytecode v6
}

