module 0xa6e6deca9e17aeae1df09be7b245d7f2f29b6efa9f5e53a525a58b3e9d0bf478::troll {
    struct TROLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROLL>(arg0, 9, b"TroLL", b"Troll", b"Troll Coin now is live", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776000392926-112b85e2cfe5cd03472c7b4f72a35173.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<TROLL>>(0x2::coin::mint<TROLL>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TROLL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROLL>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

