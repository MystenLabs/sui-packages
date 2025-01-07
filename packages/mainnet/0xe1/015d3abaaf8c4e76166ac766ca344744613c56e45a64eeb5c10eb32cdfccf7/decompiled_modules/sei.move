module 0xe1015d3abaaf8c4e76166ac766ca344744613c56e45a64eeb5c10eb32cdfccf7::sei {
    struct SEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEI>(arg0, 1, b"SEI", b"SEI", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SEI>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

