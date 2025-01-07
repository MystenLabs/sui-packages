module 0xd31fc4698f298434c559082e33f9798bb8ed02b03cdc892707fefdb2e8b913b3::frens {
    struct FRENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRENS>(arg0, 6, b"FRENS", b"Sui Frens", b"Sui Frens $FRENS are the official mascots of SUI designed and created by the developers of SUI themselves", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2Fsuifrens_1027ca98fa.jpg&w=640&q=75"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRENS>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FRENS>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRENS>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

