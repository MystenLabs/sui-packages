module 0x8ec0ccbf82f5b69347d460b46d4f4b8cd5a95ac2babae0a6ee178216b167228a::caraka {
    struct CARAKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARAKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARAKA>(arg0, 6, b"CARAKA", b"Caraka", b"Caraka is a symbol of an unbroken circle, connected to each other and a symbol of close relationships with each other.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000062272_ebf96c7ab9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARAKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CARAKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

