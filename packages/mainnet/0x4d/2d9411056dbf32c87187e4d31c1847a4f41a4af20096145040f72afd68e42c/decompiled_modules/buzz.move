module 0x4d2d9411056dbf32c87187e4d31c1847a4f41a4af20096145040f72afd68e42c::buzz {
    struct BUZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUZZ>(arg0, 6, b"BUZZ", b"Buzz Lightyer", b"Buzz Launching on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSIp3GScJUsyHGQFIaHw1CfhxMTjz07SCYwDQ&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BUZZ>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUZZ>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUZZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

