module 0x4deeb09caed3792dffb86bb36ab6df528139c97be1749e60848cc8fee4489cfe::frozen {
    struct FROZEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROZEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROZEN>(arg0, 9, b"FROZEN", x"e29d84efb88f46726f7a656e", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FROZEN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROZEN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROZEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

