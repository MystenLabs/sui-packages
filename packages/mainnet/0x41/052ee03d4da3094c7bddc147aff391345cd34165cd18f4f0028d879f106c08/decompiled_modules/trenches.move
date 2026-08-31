module 0x41052ee03d4da3094c7bddc147aff391345cd34165cd18f4f0028d879f106c08::trenches {
    struct TRENCHES has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRENCHES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRENCHES>(arg0, 6, b"TRENCHES", b"trencnches", b"trench", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suipad.online/api/images/b218854ea109f7baf93d65122558f866ba9b784fa1b2790dc56911a3788eddf8.png")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRENCHES>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRENCHES>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

