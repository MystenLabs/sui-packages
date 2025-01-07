module 0xc70db356572e8c700381f2cd26b41c5bda0bb79d7492a0bd7ea3d8f5a4d90b0a::suiwif {
    struct SUIWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWIF>(arg0, 9, b"SUIWIF", b"Sui Wif Hat", b"Sui Wif Hat Coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"<a href=\"https://imgbb.com/\"><img src=\"https://i.ibb.co/kDkYQQr/hat250.png\" alt=\"hat250\" border=\"0\"></a>")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIWIF>(&mut v2, 69000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWIF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

