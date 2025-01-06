module 0x3ac738feab81d11189a1626916d95d11987e747d30f5192926a99ada12faf172::manta {
    struct MANTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANTA>(arg0, 6, b"MANTA", b"MantaMarvin", b"Marvin is a chill guy, most of the time he just swims around in the ocean, but today he decided he wants to become the face of the $MANTA token, if you like his attitude join his fleet!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_32d55c331c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

