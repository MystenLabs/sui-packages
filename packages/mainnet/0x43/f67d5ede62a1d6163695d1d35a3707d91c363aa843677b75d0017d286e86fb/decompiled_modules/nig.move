module 0x43f67d5ede62a1d6163695d1d35a3707d91c363aa843677b75d0017d286e86fb::nig {
    struct NIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIG>(arg0, 6, b"NIG", b"Nigger", b"You Are A Nigger ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GX_64gl_Ws_AAZ_Eh9_d5dee2de00.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

