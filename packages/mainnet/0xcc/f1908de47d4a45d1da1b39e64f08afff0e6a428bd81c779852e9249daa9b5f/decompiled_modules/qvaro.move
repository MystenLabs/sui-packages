module 0xccf1908de47d4a45d1da1b39e64f08afff0e6a428bd81c779852e9249daa9b5f::qvaro {
    struct QVARO has drop {
        dummy_field: bool,
    }

    fun init(arg0: QVARO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QVARO>(arg0, 9, b"Qvaro", x"d09ad0b2d0b0d180d0be", x"d09ad0b2d0b0d180d0be20d0b7d0b5d180d0bad0b0d0bbd0be", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/765d755ee435631f63abbed81f7380b5blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QVARO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QVARO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

