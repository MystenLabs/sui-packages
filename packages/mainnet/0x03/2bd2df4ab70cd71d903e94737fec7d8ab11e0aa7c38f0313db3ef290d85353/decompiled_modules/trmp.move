module 0x32bd2df4ab70cd71d903e94737fec7d8ab11e0aa7c38f0313db3ef290d85353::trmp {
    struct TRMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRMP>(arg0, 6, b"TRMP", b"TRUMP", b"This token is meant to support Donald Trump towards his path to victory", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2302_f982f1819a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

