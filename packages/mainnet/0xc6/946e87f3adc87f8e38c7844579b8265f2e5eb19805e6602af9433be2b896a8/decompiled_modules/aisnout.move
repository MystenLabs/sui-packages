module 0xc6946e87f3adc87f8e38c7844579b8265f2e5eb19805e6602af9433be2b896a8::aisnout {
    struct AISNOUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AISNOUT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AISNOUT>(arg0, 6, b"AISNOUT", b"AiSnout by SuiAI", b"Purpose: To notify users about missing pets in their area and provide assistance for locating them..Features:.Send push notifications or SMS alerts to users when a pet goes missing nearby..Help pet owners create posters and share them on social media..Geolocation-based pet search coordination..Real-time tracking updates if the pet is found..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Missing_Pet_Alert_Agent_min_00d34e32bd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AISNOUT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AISNOUT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

