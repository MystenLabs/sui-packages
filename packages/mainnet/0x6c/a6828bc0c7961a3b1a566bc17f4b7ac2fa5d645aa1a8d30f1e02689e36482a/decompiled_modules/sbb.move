module 0x6ca6828bc0c7961a3b1a566bc17f4b7ac2fa5d645aa1a8d30f1e02689e36482a::sbb {
    struct SBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBB>(arg0, 9, b"SBB", b"SuiBigBoss", b"SuiBigBoss", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SBB>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBB>>(v1);
    }

    // decompiled from Move bytecode v6
}

