module 0x84c5958621a45f214ffc59e6c7e9984d64f7082bd3f78a0412f44d79d5b80b8b::tiggy {
    struct TIGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIGGY>(arg0, 6, b"Tiggy", b"TIGGYSUI", b"Paws up, lets prowl! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tiggy_5de77693e3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

