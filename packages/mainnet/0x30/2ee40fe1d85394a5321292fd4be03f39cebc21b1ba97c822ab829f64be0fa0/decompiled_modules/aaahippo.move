module 0x302ee40fe1d85394a5321292fd4be03f39cebc21b1ba97c822ab829f64be0fa0::aaahippo {
    struct AAAHIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAHIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAHIPPO>(arg0, 9, b"AAAHIPPO", b"aaadeng", b"AAAAAAHIPPO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FIMG_0313_8d43458fdc.jpeg&w=640&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AAAHIPPO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAHIPPO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAHIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

