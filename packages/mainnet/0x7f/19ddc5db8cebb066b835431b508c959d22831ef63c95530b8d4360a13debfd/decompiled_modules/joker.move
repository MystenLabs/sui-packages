module 0x7f19ddc5db8cebb066b835431b508c959d22831ef63c95530b8d4360a13debfd::joker {
    struct JOKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOKER>(arg0, 6, b"JOKER", b"JOKERSUI", x"57656c636f6d6520476f6f64204368696c642057686f2049732041637475616c6c79204e6175676874792c20486572652057652047617468657220546f20426520476f6f6420746f2065766572796f6e652e200a0a4f757220576562736974652068747470733a2f2f6a6f6b65722e626c6f636b636861696e2d746f6e2e78797a2f6a6f6b6572746f6e2f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreici7pgg4b3dfxl6yvhhfydq7kp25ezimf7de4xrcwe5aydfa3jv2u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JOKER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

