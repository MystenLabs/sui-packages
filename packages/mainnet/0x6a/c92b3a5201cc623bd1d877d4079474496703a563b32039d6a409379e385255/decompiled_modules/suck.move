module 0x6ac92b3a5201cc623bd1d877d4079474496703a563b32039d6a409379e385255::suck {
    struct SUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUCK>(arg0, 6, b"Suck", b"Suck the Duck", b"Hello, I'm $SUCK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pf_K_Tq_M9w_400x400_9cb1b314a1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

