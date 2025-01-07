module 0x72c9c7cbe15f266710582f11b2bf071c77702c6a1654cbbe6c1bbaa14f2ba520::redwitch {
    struct REDWITCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: REDWITCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REDWITCH>(arg0, 9, b"redwitch", b"Red Witch", b"REDWITCH IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/080/108/794/large/sangsoo-jeong-redwitch.jpg?1726695238")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<REDWITCH>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REDWITCH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REDWITCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

