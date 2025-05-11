module 0xc7e875e980d8c79d65e2f2ba317c16bb53762488c588ba215c87083882503b36::samu {
    struct SAMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAMU>(arg0, 6, b"SAMU", b"Samurai Wolf", b"The firs SAMUrai Wolf on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000068790_910f4e8a38.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAMU>>(v1);
    }

    // decompiled from Move bytecode v6
}

