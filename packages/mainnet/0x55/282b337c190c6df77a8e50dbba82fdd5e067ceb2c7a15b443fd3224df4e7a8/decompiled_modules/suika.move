module 0x55282b337c190c6df77a8e50dbba82fdd5e067ceb2c7a15b443fd3224df4e7a8::suika {
    struct SUIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKA>(arg0, 6, b"SUIKA", b"Suika the Dancing Cat", b"Suika the Dancing Cat, $SUIKA, is charming the Sui network with its adorable dance and potential for growth. As a meme coin, it's gaining traction, captivating investors with its cute appeal and community spirit.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/balloon_5eac1241_cc72919c98.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

