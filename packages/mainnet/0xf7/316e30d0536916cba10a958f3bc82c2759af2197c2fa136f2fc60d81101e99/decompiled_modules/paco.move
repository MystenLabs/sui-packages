module 0xf7316e30d0536916cba10a958f3bc82c2759af2197c2fa136f2fc60d81101e99::paco {
    struct PACO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PACO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PACO>(arg0, 6, b"PACO", b"Paco", b"Paco was Pepe best friend, but Pepe stole his girlfriend so Paco became fat n depressed... Join his comeback and revenge plan!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PACO_Logo_5d35b885a9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PACO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PACO>>(v1);
    }

    // decompiled from Move bytecode v6
}

