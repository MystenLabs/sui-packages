module 0x296f91353088721a284783096830100663d0b0c27d2ac4d668e56f50dae0fd22::Coolio {
    struct COOLIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOLIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOLIO>(arg0, 9, b"COOL", b"Coolio", b"cool mfer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GzOfVlYXcAALg5K?format=jpg&name=medium")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COOLIO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOLIO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

