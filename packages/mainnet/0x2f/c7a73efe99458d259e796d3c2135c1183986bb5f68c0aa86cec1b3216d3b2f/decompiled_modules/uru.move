module 0x2fc7a73efe99458d259e796d3c2135c1183986bb5f68c0aa86cec1b3216d3b2f::uru {
    struct URU has drop {
        dummy_field: bool,
    }

    fun init(arg0: URU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<URU>(arg0, 9, b"uru", b"uru", b"uruu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<URU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<URU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<URU>>(v1);
    }

    // decompiled from Move bytecode v6
}

