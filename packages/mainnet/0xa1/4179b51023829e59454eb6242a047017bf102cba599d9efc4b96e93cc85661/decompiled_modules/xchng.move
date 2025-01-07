module 0xa14179b51023829e59454eb6242a047017bf102cba599d9efc4b96e93cc85661::xchng {
    struct XCHNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: XCHNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XCHNG>(arg0, 6, b"XCHNG", b"Chainge app", x"436861696e6765207c204f6e65204d61726b6574706c6163652e20416c6c2043727970746f2e0a0a436861696e6765207374616e6473206173202020202d20202c207365616d6c6573736c79206d657267696e67206c697175696469747920736f7572636573206163726f737320616c6c20636861696e732e0a0a68747470733a2f2f636861696e67652e66696e616e63650a0a4e65777320466565643a2040436861696e676546696e616e63654e6577730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003447_66e4b83103.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XCHNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XCHNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

