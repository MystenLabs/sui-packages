module 0x4fd287b29db6b10dbb12154fb5e4e2e25de51223629b14bac24fdd04e330c555::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN>(arg0, 9, b"Token", b"Token", b"Tokensssda sdff", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TOKEN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

