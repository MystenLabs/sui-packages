module 0xc65164b07816b999711f193b445c526eb219c3566cfe03a6ebd1322fa1f5d61c::gangs {
    struct GANGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GANGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GANGS>(arg0, 6, b"GANGS", b"REAL GANGS ON SUI", b"SUI Network Gangsters Meeting Place", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_8_707480d774.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GANGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GANGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

