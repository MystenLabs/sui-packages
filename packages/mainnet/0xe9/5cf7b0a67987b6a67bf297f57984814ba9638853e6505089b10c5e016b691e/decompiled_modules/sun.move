module 0xe95cf7b0a67987b6a67bf297f57984814ba9638853e6505089b10c5e016b691e::sun {
    struct SUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUN>(arg0, 9, b"sUN", b"SUN", b"Sui Sun. The sun that rose over the sea.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://p.turbosquid.com/ts-thumb/Wh/OBZwPJ/97/blue_sun008/png/1635638574/600x600/fit_q87/9a0472c3de57ad276cb9a1e875089c9f9ed23a9e/blue_sun008.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUN>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

