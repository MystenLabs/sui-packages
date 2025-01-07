module 0xf27183b838cd260c96b8671e0852eb529993e429814b79f3fe1f4b4aa0683397::memek_adi {
    struct MEMEK_ADI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_ADI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_ADI>(arg0, 6, b"MEMEKADI", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_ADI>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_ADI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_ADI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

