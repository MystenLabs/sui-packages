module 0xd3b0b2043259e5844ec4b53094e14c48b483ca7511fb389b6bbf2b2d8a1947fe::db {
    struct DB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DB>(arg0, 6, b"DB", b"Donkey Balls", b"Donkey Balls DB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749375300270.33")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

