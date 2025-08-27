module 0x7db69251b87013a0bc40c0b4a51d3c4a114d81038df52dd09bfed085ee6dd142::Trolly {
    struct TROLLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROLLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROLLY>(arg0, 9, b"TROLLLL", b"Trolly", b"troling on the net. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GzXikXebUAAWOjJ?format=jpg&name=large")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TROLLY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROLLY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

