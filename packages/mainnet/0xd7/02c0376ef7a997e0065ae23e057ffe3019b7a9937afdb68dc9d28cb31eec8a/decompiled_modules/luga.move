module 0xd702c0376ef7a997e0065ae23e057ffe3019b7a9937afdb68dc9d28cb31eec8a::luga {
    struct LUGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUGA>(arg0, 9, b"LUGA", b"LUGA", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LUGA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUGA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

