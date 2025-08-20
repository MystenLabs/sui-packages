module 0x51ea3159a85513ca1b3ae4be43fed416380fbfefc543dc2dbb5e06ef24e4bd4c::epm {
    struct EPM has drop {
        dummy_field: bool,
    }

    fun init(arg0: EPM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EPM>(arg0, 9, b"EPM", b"EYES PEELED 1MILL", b"Do you hate money anon?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EPM>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EPM>>(v2, @0xde54a2563797ee480fa49320d104051a158973abef8d516e8f9b5701636a2ca7);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EPM>>(v1);
    }

    // decompiled from Move bytecode v6
}

