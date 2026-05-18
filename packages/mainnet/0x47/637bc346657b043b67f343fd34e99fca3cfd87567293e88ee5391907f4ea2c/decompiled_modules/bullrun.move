module 0x47637bc346657b043b67f343fd34e99fca3cfd87567293e88ee5391907f4ea2c::bullrun {
    struct BULLRUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLRUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLRUN>(arg0, 9, b"BULLRUN                           ", b"Bullrun                                                           ", b"Pure meme coin                                                                                                                                                                                                                                                                                                                                                                                                                                                        ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://flopfun.com/icon/77264934-fba4-4cf3-8e75-9f33a4905ce1.jpg                                                                                                                                                   ")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLRUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BULLRUN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

