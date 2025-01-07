module 0x5c2889e998ddb215ccff8caa7ae4b98e7b60cd22a8717faf2afa5bf03d54a902::grace {
    struct GRACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRACE>(arg0, 9, b"GRACE", b"Fallen Grace", b"Another great model. Grace!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/695/598/large/shatiryan-volodya-01-main-camera-1.jpg?1728302697")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GRACE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRACE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRACE>>(v1);
    }

    // decompiled from Move bytecode v6
}

