module 0x9e41fe8362b33a2635e363d80b0d36cc6538dd221a2ce62d80d8903665a88442::ssp {
    struct SSP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSP>(arg0, 6, b"SSP", b"SwaggeringSpaniel", b"The SwaggeringSpaniel ($SSP) token, inspired by the image of a strutting poodle, has great potential in niche markets by virtue of its unique positioning, interesting community and reliable technology, aiming to become an iconic meme token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6600_5793be6a4d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSP>>(v1);
    }

    // decompiled from Move bytecode v6
}

