module 0x505056e678dbba59c0cf5ab7e12719ceba67c79545ebf6a1a9eb96ea35bd3929::memek_kyuda {
    struct MEMEK_KYUDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_KYUDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_KYUDA>(arg0, 6, b"MEMEKKYUDA", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_KYUDA>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_KYUDA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_KYUDA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

