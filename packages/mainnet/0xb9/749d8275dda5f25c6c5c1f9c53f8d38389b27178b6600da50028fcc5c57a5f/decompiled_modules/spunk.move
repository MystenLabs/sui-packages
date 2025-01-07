module 0xb9749d8275dda5f25c6c5c1f9c53f8d38389b27178b6600da50028fcc5c57a5f::spunk {
    struct SPUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPUNK>(arg0, 6, b"SPUNK", b"SUI PUNKS", b"SUI PUNK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PUNK_f6cc046c28.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPUNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPUNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

