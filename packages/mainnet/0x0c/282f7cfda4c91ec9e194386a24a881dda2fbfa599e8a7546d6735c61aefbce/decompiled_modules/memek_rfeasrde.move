module 0xc282f7cfda4c91ec9e194386a24a881dda2fbfa599e8a7546d6735c61aefbce::memek_rfeasrde {
    struct MEMEK_RFEASRDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_RFEASRDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_RFEASRDE>(arg0, 6, b"MEMEKRFEASRDE", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_RFEASRDE>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_RFEASRDE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_RFEASRDE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

