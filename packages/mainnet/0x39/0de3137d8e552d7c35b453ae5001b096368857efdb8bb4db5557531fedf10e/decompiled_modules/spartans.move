module 0x390de3137d8e552d7c35b453ae5001b096368857efdb8bb4db5557531fedf10e::spartans {
    struct SPARTANS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPARTANS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPARTANS>(arg0, 9, b"SPARTANS", b"Sui Spartans", b"HODL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0x114eee493a909a4eba20bd2bd86edd4f29342c88.png?size=xl&key=96147b")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPARTANS>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPARTANS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPARTANS>>(v1);
    }

    // decompiled from Move bytecode v6
}

