module 0xd0330d7ed609dba13f1d9f215c18b149e18a3cb25d7a18309cf592e18cc7a377::d1ck {
    struct D1CK has drop {
        dummy_field: bool,
    }

    fun init(arg0: D1CK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<D1CK>(arg0, 6, b"D1CK", b"DICK", b"Big Short Term - your dick is short", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig2cr662fur3hlzco4yoh4ju66brmnxr3v4xxa2322nacaehsz7a4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<D1CK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<D1CK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

