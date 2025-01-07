module 0x4210cc67e238f54aa143d780ac667070e9d70322716c4efbb0242c63b2a0485e::shrk {
    struct SHRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRK>(arg0, 6, b"SHRK", b"SUI Shark", b"Meme Token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_886c946d53.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHRK>>(v1);
    }

    // decompiled from Move bytecode v6
}

