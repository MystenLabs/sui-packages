module 0x2606e51dff123ebee7fd31efbe54d4e4a1ec95c48a1ad1778c2d558480086a70::putin {
    struct PUTIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUTIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUTIN>(arg0, 6, b"PUTIN", b"OFFICIAL PUTIN MEME", b"Vladimir Putin is a Russian politician and former intelligence officer who has served as the President of Russia since 1999, with a brief tenure as Prime Minister. Known for consolidating power and shaping modern Russian politics, he has been a central figure in global affairs, often marked by controversial policies and geopolitical strategies.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1421_9cc0dda562.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUTIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUTIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

