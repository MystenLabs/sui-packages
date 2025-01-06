module 0x48659844dd2d2fc3472e5b56259558457a903c67875e295711de1df01975ea80::manta {
    struct MANTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANTA>(arg0, 6, b"MANTA", b"MantaMarvin", b"Marvin is a chill guy, most of the time he just swims around in the ocean, but today he decided he wants to become the face of the $MANTA token, if you like his attitude join his fleet!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736190300518.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANTA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANTA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

