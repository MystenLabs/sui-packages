module 0x53b3ae159e4260f74d3a49cca7cba544f5d7c94d80f8ac777a90715c5c467afa::fomosui {
    struct FOMOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOMOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOMOSUI>(arg0, 6, b"Fomosui", b"Fomo", b"Let do together FOMO SUI Project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fomo_sui_it_03e73c47a4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOMOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOMOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

