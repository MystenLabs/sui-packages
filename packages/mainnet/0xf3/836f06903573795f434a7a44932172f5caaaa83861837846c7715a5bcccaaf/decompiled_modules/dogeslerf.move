module 0xf3836f06903573795f434a7a44932172f5caaaa83861837846c7715a5bcccaaf::dogeslerf {
    struct DOGESLERF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGESLERF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGESLERF>(arg0, 6, b"DogeSlerf", b"DogeSlerf on SUI", b"Ultimate chill, trading memes & dreams on the blockchain! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Xy_O_Hax_P_400x400_803146e3b0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGESLERF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGESLERF>>(v1);
    }

    // decompiled from Move bytecode v6
}

