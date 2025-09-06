module 0xf6e5489763a89100600acbd26ebd098e55d3fe9719cda3891a3eb639678d457b::Fuack {
    struct FUACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUACK>(arg0, 9, b"FUACK", b"Fuack", b"fuack you. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/G0H_iH8WgAAb9Ht?format=jpg&name=small")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUACK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUACK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

