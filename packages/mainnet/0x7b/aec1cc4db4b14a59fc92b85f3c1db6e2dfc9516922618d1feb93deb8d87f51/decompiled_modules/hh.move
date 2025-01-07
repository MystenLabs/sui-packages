module 0x7baec1cc4db4b14a59fc92b85f3c1db6e2dfc9516922618d1feb93deb8d87f51::hh {
    struct HH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HH>(arg0, 9, b"hh", b"huu", b"h", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HH>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HH>>(v1);
    }

    // decompiled from Move bytecode v6
}

