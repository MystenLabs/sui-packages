module 0xa3f911b626c9aabea6f4bbad1fcc9c6ebf505c8cf1ac8423a8a31bef7406ccf9::pirate {
    struct PIRATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIRATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIRATE>(arg0, 6, b"PIRATE", b"Pirate Dog", x"4a75737420612050697261746520446f6721210a0a61726520796f7520726561647920746f207361696c3f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000037656_2d99bf8f97.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIRATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIRATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

