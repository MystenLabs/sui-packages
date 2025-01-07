module 0xbce9336df9cb3076cc5ce5d674ca37ed836d19d75ec704231266684258733cba::cyberpunk {
    struct CYBERPUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYBERPUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<CYBERPUNK>(arg0, 6, b"CyberPunk", b"Cyber", b"alsoaso", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/shiba_dogs_f38f42910d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYBERPUNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<CYBERPUNK>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CYBERPUNK>>(v2);
    }

    // decompiled from Move bytecode v6
}

