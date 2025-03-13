module 0xd9e1213fd3f5e6fb9c46f046ac75ca807ee419628a312b1f80fe434e3908e308::trust {
    struct TRUST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUST>(arg0, 9, b"TRUST", b"Trustmebro", b"hiede", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/2ea036baed711b696cc266fe9a155123blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

