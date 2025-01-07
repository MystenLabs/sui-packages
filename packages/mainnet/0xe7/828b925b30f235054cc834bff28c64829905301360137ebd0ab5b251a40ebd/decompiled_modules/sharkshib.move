module 0xe7828b925b30f235054cc834bff28c64829905301360137ebd0ab5b251a40ebd::sharkshib {
    struct SHARKSHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKSHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKSHIB>(arg0, 6, b"Sharkshib", b"Shib in Shark world", x"4120736869626120696e7520646f6720696e2074686520536861726b20776f726c642020746f20636f6e74726f6c20736861726b73200a2f2f2f2f2f2f2f2f2f0a2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f0a2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f2f0a3a3a3a3a3a3a3a3a3a3a3a3a3a3a3a3a3a3a3a3a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000156726_3ad2417972.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKSHIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARKSHIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

