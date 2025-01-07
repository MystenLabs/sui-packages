module 0xd34fb627407e2b53844d5c665362b46be0000ec6520d7f3c3082851531a47dc4::funcat {
    struct FUNCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUNCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUNCAT>(arg0, 9, b"FUNCAT", b"FCAT", b"CAT ON FUN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f6aaf6ab335b62b69da73884d658108ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUNCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUNCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

