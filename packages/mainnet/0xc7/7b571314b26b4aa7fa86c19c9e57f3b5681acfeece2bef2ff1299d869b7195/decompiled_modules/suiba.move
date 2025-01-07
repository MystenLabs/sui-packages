module 0xc77b571314b26b4aa7fa86c19c9e57f3b5681acfeece2bef2ff1299d869b7195::suiba {
    struct SUIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBA>(arg0, 9, b"SUIBA", b"Suiba", b"Emerging from Shiba's boundless love, Suiba, your liquid companion, journeys with you on the Sui chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.suibacoin.com/suiba.svg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIBA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

