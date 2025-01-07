module 0x49b9d8fc9fa5ff60773f271554637773c3f1c1ec11e686dccd1ceb6021251015::suibananado {
    struct SUIBANANADO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBANANADO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBANANADO>(arg0, 6, b"SuiBananado", b"Sui Bananado", b"memcoin CTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_2_73e0b70c13.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBANANADO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBANANADO>>(v1);
    }

    // decompiled from Move bytecode v6
}

