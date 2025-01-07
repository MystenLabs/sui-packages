module 0x4361a28d69cabbdd04fd1cdb0e7f1524fa3682d69fc48a87d5308cc9061e7a9f::bad {
    struct BAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAD>(arg0, 6, b"BAD", b"BAD MOUTH IS RUG", b"This token is to remind everyone that the project Badmouth is a rugpull. It has rugged at least 3 times this month. It will continue to rug. This token is created as a community bulletin or notice about serial ruggers like Badmouth. Do not buy!!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733609299893.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

