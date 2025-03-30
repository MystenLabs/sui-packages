module 0x12e750d7e3836bf1a386b93e8b96a0dcdab5e1b73261dee9369deb76481e8e7e::sai {
    struct SAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAI>(arg0, 9, b"SAI", b"SAITAMA", b"The real hero", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e45b7f2c0d20a3a42615a6f4b1866da3blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

