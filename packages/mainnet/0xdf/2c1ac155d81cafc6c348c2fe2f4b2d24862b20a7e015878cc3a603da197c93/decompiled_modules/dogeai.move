module 0xdf2c1ac155d81cafc6c348c2fe2f4b2d24862b20a7e015878cc3a603da197c93::dogeai {
    struct DOGEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DOGEAI>(arg0, 6, b"DOGEAI", b"DOGEAi by SuiAI", b"AI project bringing awareness to government spending and over-regulation. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Hs_QD_5zgz_400x400_c79957778b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOGEAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

