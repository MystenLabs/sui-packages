module 0xcb720d92e0ab7bd9960d0cb89799026c3fe4c590bca4061b3d900bb767de2b05::mascat {
    struct MASCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MASCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MASCAT>(arg0, 6, b"MASCAT", b"Master Chef Cat", b"Folow me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaev2fkrhqcekec5wa6w6ubahrbuymxqmshrbpeq3jutmqo5euwqu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MASCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MASCAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

