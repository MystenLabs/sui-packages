module 0xe43974ae79eb096d00d1050dfd5a5c221695046ac85c638af2bb5c6d4c53e781::gigsui {
    struct GIGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIGSUI>(arg0, 6, b"GIGSUI", b"GIGA SUI", b"Giga Sui, dive into crypto's giga-gains and watch your assets soar to new heights in DeFi!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gig_3c5da58df9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

