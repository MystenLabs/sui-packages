module 0x50dd9e4852b30a8c06aac4f73340520f02ab996b5b4acc9c0a928fed66a27240::Black_Cat {
    struct BLACK_CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACK_CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACK_CAT>(arg0, 9, b"BCAT", b"Black Cat", b"a black cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GzrVvwhasAAy8mn?format=jpg&name=medium")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLACK_CAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACK_CAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

