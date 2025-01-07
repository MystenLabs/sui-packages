module 0xe39a43d6464b7fcc37ea78ab01aa1963880910763027881fc81858a36365ec14::suibananado {
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

