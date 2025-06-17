module 0x97d886cf53f5cc9e90dc68f09d69dc3a0ba44bae3c66b31300873edd1ee5486b::fuckfartin {
    struct FUCKFARTIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCKFARTIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCKFARTIN>(arg0, 6, b"FUCKFARTIN", b"FARTIN4U", b"Fucking gooner rugged us. I hope they have nightmares, and I hope all their farts come with a little bit of poop. You know what to do. Let's make him feel bad :)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1750143982692.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUCKFARTIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCKFARTIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

