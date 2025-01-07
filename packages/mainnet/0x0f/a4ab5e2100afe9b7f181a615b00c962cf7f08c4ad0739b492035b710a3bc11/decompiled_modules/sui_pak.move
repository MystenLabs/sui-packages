module 0xfa4ab5e2100afe9b7f181a615b00c962cf7f08c4ad0739b492035b710a3bc11::sui_pak {
    struct SUI_PAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_PAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_PAK>(arg0, 6, b"SUIPAK", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_PAK>>(v1);
        0x2::coin::mint_and_transfer<SUI_PAK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_PAK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

