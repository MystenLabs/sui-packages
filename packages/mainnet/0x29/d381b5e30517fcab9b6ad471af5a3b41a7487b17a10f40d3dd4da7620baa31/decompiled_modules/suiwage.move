module 0x29d381b5e30517fcab9b6ad471af5a3b41a7487b17a10f40d3dd4da7620baa31::suiwage {
    struct SUIWAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWAGE>(arg0, 6, b"SUIWAGE", b"SUIWAGE STATION", b"The ultimate shit coin! No utility, just pure speculation. No socials just pumping more shit into your feed.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_fx_3_89d8ea48ae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWAGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWAGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

