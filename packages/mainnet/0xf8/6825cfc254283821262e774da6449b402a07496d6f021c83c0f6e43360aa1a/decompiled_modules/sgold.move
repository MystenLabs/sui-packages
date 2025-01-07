module 0xf86825cfc254283821262e774da6449b402a07496d6f021c83c0f6e43360aa1a::sgold {
    struct SGOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGOLD>(arg0, 9, b"SGOLD", b"Sui gold", b"the sui gold", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SGOLD>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGOLD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGOLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

