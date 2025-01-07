module 0x59be589de84bac76f4d0cf7233902a6744fd2e2348ad5ae6c4940fe6771949bb::monkey {
    struct MONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKEY>(arg0, 6, b"Monkey", b"Mokey SUI", b"meme on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731863874017.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MONKEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKEY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

