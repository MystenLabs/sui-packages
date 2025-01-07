module 0xaaee6554ed15bfced216cf247d7edf701352e3a39b8cd3674c23a2d5172dfa55::chadcat {
    struct CHADCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHADCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHADCAT>(arg0, 9, b"CHADCAT", b"Chad Cat on SUI", b"Chad's Team backed 7K Project on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1a05776e7abeda7dbd39ba4b3de29e57blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHADCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHADCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

