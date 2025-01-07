module 0xdddb3f7fde8fd8c2ef5c23f84d8238a60a221d019b414a87f29d8af035e32c1::pro {
    struct PRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRO>(arg0, 9, b"PRO", b"Cryto prom", b"funny cry", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ea72aa29d4d6bf051b8ae44b6d17071eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

