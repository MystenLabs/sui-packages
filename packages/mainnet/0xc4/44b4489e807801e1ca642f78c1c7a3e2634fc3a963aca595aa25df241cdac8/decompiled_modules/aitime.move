module 0xc444b4489e807801e1ca642f78c1c7a3e2634fc3a963aca595aa25df241cdac8::aitime {
    struct AITIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: AITIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AITIME>(arg0, 9, b"AITIME", b"Ai prime ", b"Artificial intelligence ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AITIME>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AITIME>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AITIME>>(v1);
    }

    // decompiled from Move bytecode v6
}

