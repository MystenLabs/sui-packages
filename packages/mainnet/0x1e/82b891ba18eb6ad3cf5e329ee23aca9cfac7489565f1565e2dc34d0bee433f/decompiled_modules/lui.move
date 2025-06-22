module 0x1e82b891ba18eb6ad3cf5e329ee23aca9cfac7489565f1565e2dc34d0bee433f::lui {
    struct LUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUI>(arg0, 6, b"LUI", b"scooterlui", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LUI>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LUI>>(v2);
    }

    // decompiled from Move bytecode v6
}

