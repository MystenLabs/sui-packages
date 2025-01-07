module 0x98e9a83a7ad8d44443945b53ac55961e1cbcfe028afaa459f020dca047f8fbd0::dev {
    struct DEV has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEV>(arg0, 9, b"DEV", b"dev 103", b"DEV Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://strapi-dev.scand.app/uploads/sui_c07df05f00.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DEV>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEV>>(v2, @0x44daad1d00b1cf1d9d34e65d4f0e05b8a4540441b3f95048f1bd686b93b9364a);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEV>>(v1);
    }

    // decompiled from Move bytecode v6
}

