module 0x603fc19ce895a3ec37e1d5c0f31e200a3ca201dd598a3d06f6e977bd30e5187::memek_ended {
    struct MEMEK_ENDED has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_ENDED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_ENDED>(arg0, 6, b"MEMEKENDED", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_ENDED>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_ENDED>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_ENDED>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

