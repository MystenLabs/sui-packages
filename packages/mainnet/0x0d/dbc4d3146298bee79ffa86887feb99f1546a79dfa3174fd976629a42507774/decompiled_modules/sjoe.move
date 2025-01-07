module 0xddbc4d3146298bee79ffa86887feb99f1546a79dfa3174fd976629a42507774::sjoe {
    struct SJOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SJOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SJOE>(arg0, 9, b"SJOE", b"Sleepy Joe", b"zzzzzzzzzzzzzzzzzzzzzzz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/63d2e1b4bc2aa015c940831f84a3625fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SJOE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SJOE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

