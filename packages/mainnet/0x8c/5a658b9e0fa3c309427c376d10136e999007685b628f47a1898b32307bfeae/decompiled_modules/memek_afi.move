module 0x8c5a658b9e0fa3c309427c376d10136e999007685b628f47a1898b32307bfeae::memek_afi {
    struct MEMEK_AFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_AFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_AFI>(arg0, 6, b"MEMEKAFI", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_AFI>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_AFI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_AFI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

