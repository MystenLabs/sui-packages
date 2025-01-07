module 0xb6000963388533518657e9f8161900be3aedc7dfe974763d7d314f677ad6c0e4::mmeow {
    struct MMEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMEOW>(arg0, 9, b"MMeow", b"MeowMeowCoin", b"New Hero of the land... (just a test)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/65c6016e10d2ac0e06764481e260a0ccblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMEOW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMEOW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

