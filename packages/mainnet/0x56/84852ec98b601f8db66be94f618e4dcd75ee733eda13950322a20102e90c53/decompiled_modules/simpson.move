module 0x5684852ec98b601f8db66be94f618e4dcd75ee733eda13950322a20102e90c53::simpson {
    struct SIMPSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMPSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMPSON>(arg0, 9, b"SIMPSON", x"e2ad90efb88f53696d70736f6e", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SIMPSON>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMPSON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIMPSON>>(v1);
    }

    // decompiled from Move bytecode v6
}

