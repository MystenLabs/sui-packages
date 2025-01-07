module 0x1a68022b3ad2df422c4f3918b8abb886e2c8eaab81d71c5e1082cf14c0116a6c::sblub {
    struct SBLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBLUB>(arg0, 6, b"SBLUB", b"BLUBonSUI", b"A Dirty Fish in the Waters of the Sui Ocean. The #1 Meme on $SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BLUB_93efb19de9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

