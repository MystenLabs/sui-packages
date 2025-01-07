module 0x21b89f5745c50ff5bca471ad9291896162f03c7dbfaae2cae131244dd8d9178c::sulana {
    struct SULANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SULANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SULANA>(arg0, 9, b"SULANA", b"SuiLana", b"Better then sol a hundred times", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1219190114296844288/Ry_AYGeR.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SULANA>(&mut v2, 300000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SULANA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SULANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

