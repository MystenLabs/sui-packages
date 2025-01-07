module 0x44cb3c9b72d69174e1a95dace014447feef746fe4a1ee4b769e398cdb7158836::memek_rfeasrdb {
    struct MEMEK_RFEASRDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_RFEASRDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_RFEASRDB>(arg0, 6, b"MEMEKRFEASRDB", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_RFEASRDB>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_RFEASRDB>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_RFEASRDB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

