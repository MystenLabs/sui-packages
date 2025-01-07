module 0x404bcb09e2fa747755b76a8a270af41ef5efcd079e3fd272658cadcd0df9bcd7::cfish {
    struct CFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CFISH>(arg0, 6, b"CFISH", b"CRAB FISH", b"THE OG CRAB FISH. NOTHING MORE. CANT BEAT THE CRAB WITH FISH.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Schermafbeelding_2024_09_27_om_10_34_04_06897246a4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

