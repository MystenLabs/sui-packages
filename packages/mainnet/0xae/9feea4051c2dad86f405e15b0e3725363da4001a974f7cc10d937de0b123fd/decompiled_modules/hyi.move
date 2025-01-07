module 0xae9feea4051c2dad86f405e15b0e3725363da4001a974f7cc10d937de0b123fd::hyi {
    struct HYI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYI>(arg0, 9, b"HYI", b"HYI", b"HYI Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HYI>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HYI>>(v1);
    }

    // decompiled from Move bytecode v6
}

