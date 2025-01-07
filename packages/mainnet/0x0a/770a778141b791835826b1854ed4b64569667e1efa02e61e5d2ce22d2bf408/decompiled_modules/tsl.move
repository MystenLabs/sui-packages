module 0xa770a778141b791835826b1854ed4b64569667e1efa02e61e5d2ce22d2bf408::tsl {
    struct TSL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSL>(arg0, 9, b"TSL", b"TESLA", b"Tesla Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TSL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSL>>(v1);
    }

    // decompiled from Move bytecode v6
}

