module 0xac773547142d93f701b63c1e4e5cd94ec831844fc653d2aae1f273efe5cde5e4::wal {
    struct WAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAL>(arg0, 9, b"WAL", b"WALWAL", b"1000 point", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c191c9cc938be6175ca44ca44e109b7eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

