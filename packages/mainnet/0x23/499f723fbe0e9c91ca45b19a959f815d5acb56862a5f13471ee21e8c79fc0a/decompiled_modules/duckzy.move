module 0x23499f723fbe0e9c91ca45b19a959f815d5acb56862a5f13471ee21e8c79fc0a::duckzy {
    struct DUCKZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKZY>(arg0, 6, b"Duckzy", b"Duckzy Sui", b"hewwoo it's duckzy! kweeeeck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jim_vermeer_duckmario_6_1_2b59a799cc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

