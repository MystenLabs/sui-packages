module 0x57bb9a61b826e31ad4c1cc4f2fc8faf1ac9092b797e9a2696fe7930256c5f9ed::bn {
    struct BN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BN>(arg0, 9, b"bn", b"bnhh", b"hjmmmmmmmmmmmmmm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"fhmmmmmmmmmmmmmmmmmmmmm")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BN>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BN>>(v1);
    }

    // decompiled from Move bytecode v6
}

