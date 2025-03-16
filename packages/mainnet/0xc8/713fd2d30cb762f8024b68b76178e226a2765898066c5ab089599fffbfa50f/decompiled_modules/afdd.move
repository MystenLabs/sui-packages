module 0xc8713fd2d30cb762f8024b68b76178e226a2765898066c5ab089599fffbfa50f::afdd {
    struct AFDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFDD>(arg0, 9, b"Afdd", b"dfd", b"gfgfg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a92a6ccf6fab2515c91a28206915e7ccblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AFDD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFDD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

