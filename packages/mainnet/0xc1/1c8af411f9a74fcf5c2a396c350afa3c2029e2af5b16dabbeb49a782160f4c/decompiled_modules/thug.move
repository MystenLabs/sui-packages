module 0xc11c8af411f9a74fcf5c2a396c350afa3c2029e2af5b16dabbeb49a782160f4c::thug {
    struct THUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: THUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THUG>(arg0, 6, b"THUG", b"Thug Life", b"Enter the world of THUG LIFE, the meme crypto token that's taking the blockchain by storm! Inspired by the iconic street culture and a spirit of resilience", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thug_life_03932b0363.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

