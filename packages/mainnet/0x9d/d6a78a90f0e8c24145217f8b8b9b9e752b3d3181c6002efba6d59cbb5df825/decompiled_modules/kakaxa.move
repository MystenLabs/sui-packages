module 0x9dd6a78a90f0e8c24145217f8b8b9b9e752b3d3181c6002efba6d59cbb5df825::kakaxa {
    struct KAKAXA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAKAXA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAKAXA>(arg0, 6, b"KAKAXA", b"KAKAXA COIN", b"KAKAXA coin just memecoin or something more", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/KAKAXA_da88c4f2f2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAKAXA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAKAXA>>(v1);
    }

    // decompiled from Move bytecode v6
}

