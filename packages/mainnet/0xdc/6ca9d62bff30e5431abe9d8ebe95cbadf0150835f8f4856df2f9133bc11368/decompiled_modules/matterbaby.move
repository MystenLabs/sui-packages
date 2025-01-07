module 0xdc6ca9d62bff30e5431abe9d8ebe95cbadf0150835f8f4856df2f9133bc11368::matterbaby {
    struct MATTERBABY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MATTERBABY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MATTERBABY>(arg0, 9, b"MATTERBABY", b"Matter Baby", b"What's the matter baby?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MATTERBABY>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MATTERBABY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MATTERBABY>>(v1);
    }

    // decompiled from Move bytecode v6
}

