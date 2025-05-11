module 0xfff83f9ed0ae30278dc158875d2ceaaccb77c0cdde59e20a3c31cfde569e472e::kokok {
    struct KOKOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOKOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOKOK>(arg0, 6, b"KOKOK", b"Kokok The Roach", b"Hey fellas, meet KoKoK - the symbol of resilience traders, unkillable forever.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000068769_87aec2a9ec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOKOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOKOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

