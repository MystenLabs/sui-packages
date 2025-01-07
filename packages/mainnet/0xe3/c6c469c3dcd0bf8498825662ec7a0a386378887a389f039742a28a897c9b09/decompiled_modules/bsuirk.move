module 0xe3c6c469c3dcd0bf8498825662ec7a0a386378887a389f039742a28a897c9b09::bsuirk {
    struct BSUIRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSUIRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSUIRK>(arg0, 6, b"BSUIRK", b"Baby Suirk", b"Baaaby Suirk Dadadadada", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/_c45df78cfb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSUIRK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSUIRK>>(v1);
    }

    // decompiled from Move bytecode v6
}

