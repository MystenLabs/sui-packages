module 0xd19a118f51978d80624243bba87e245d960cef2b6c1997e3197f27ed6662c436::daddy {
    struct DADDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DADDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DADDY>(arg0, 6, b"DADDY", b"Daddy", b"$DADDY isn't just a cryptocurrency; it's a symbol of progress, for futuristic transactions, a beacon for those who think ahead. it's clear that the future belongs to those who embrace innovations like $DADDY, transcending boundaries & paving a new era in finance and technology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1726341328938_a10179878239144c72f7546f90ab61ef_95fde2e5ba.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DADDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DADDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

