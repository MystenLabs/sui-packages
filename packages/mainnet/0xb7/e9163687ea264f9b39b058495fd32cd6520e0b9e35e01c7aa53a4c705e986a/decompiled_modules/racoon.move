module 0xb7e9163687ea264f9b39b058495fd32cd6520e0b9e35e01c7aa53a4c705e986a::racoon {
    struct RACOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: RACOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RACOON>(arg0, 6, b"RACOON", b"Racoon City", b"RACOON is the coolest character on SUI. RACOON is a playboy, a moon chaser, and the most successful degen gambler.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_1113ec23bb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RACOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RACOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

