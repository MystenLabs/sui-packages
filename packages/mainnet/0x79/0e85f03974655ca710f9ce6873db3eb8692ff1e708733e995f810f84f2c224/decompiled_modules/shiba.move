module 0x790e85f03974655ca710f9ce6873db3eb8692ff1e708733e995f810f84f2c224::shiba {
    struct SHIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBA>(arg0, 6, b"Shiba", b"SHIBA SAGA", b"The Next Shib on Sui, together we can make this moonshot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241028_224236_5050537b81.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

