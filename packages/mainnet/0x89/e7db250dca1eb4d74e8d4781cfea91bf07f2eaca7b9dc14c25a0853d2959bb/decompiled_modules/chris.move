module 0x89e7db250dca1eb4d74e8d4781cfea91bf07f2eaca7b9dc14c25a0853d2959bb::chris {
    struct CHRIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHRIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHRIS>(arg0, 9, b"CHRIS", b"ChrisCoin", b"A coin for Chris", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHRIS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHRIS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHRIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

