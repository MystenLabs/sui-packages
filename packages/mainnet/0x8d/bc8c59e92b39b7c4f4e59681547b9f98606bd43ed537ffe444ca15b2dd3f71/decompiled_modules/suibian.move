module 0x8dbc8c59e92b39b7c4f4e59681547b9f98606bd43ed537ffe444ca15b2dd3f71::suibian {
    struct SUIBIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBIAN>(arg0, 6, b"SUIBIAN", b"SB", b"Strive not to run away, just play casually", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/843b3332b07427cf0accb077ff775134_9f12465dcb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBIAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBIAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

