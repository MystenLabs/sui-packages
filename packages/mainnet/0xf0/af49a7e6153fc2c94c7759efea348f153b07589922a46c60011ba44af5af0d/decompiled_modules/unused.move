module 0xf0af49a7e6153fc2c94c7759efea348f153b07589922a46c60011ba44af5af0d::unused {
    struct UNUSED has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNUSED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNUSED>(arg0, 6, b"UNUSED", b"A brand new ethereum killer #38152751 (SUI)", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b" ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<UNUSED>(&mut v2, 1238176874000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNUSED>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNUSED>>(v1);
    }

    // decompiled from Move bytecode v6
}

