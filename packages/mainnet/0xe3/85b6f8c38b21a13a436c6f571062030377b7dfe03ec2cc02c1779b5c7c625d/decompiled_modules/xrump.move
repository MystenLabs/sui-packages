module 0xe385b6f8c38b21a13a436c6f571062030377b7dfe03ec2cc02c1779b5c7c625d::xrump {
    struct XRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: XRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XRUMP>(arg0, 6, b"Xrump", b"Zrump", b"Xrump On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5497_1115b821b1_6a9e2a8355.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

