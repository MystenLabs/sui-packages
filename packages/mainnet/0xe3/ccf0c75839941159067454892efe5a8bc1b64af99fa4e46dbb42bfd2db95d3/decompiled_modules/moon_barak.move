module 0xe3ccf0c75839941159067454892efe5a8bc1b64af99fa4e46dbb42bfd2db95d3::moon_barak {
    struct MOON_BARAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOON_BARAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOON_BARAK>(arg0, 6, b"Moon barak", b"Moonbarak", b"The Richest King on SUI, ready to moon from Dubai to the stars", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreicsaiyfasopsxdiyu7dtmvjdxle6amr3ascbygkjhtixnm66c6uki")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOON_BARAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOON_BARAK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

