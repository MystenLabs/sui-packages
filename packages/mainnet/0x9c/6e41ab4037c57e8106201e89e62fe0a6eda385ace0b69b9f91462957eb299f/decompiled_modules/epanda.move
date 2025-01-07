module 0x9c6e41ab4037c57e8106201e89e62fe0a6eda385ace0b69b9f91462957eb299f::epanda {
    struct EPANDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: EPANDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EPANDA>(arg0, 6, b"EPANDA", b"epanda", b"I'm panda", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000154_18e48bdff4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EPANDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EPANDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

