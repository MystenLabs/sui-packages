module 0xfd1e43a3cb89b80ecd5d4911508fe155636fe2a06fa5d454569b1273a2b1729a::rainer {
    struct RAINER has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAINER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAINER>(arg0, 6, b"RAINER", b"RAINER SUI", b"RAINER IS HERE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f2fe63fb_eda1_4764_9378_41fba1abadd5_9281384524.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAINER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAINER>>(v1);
    }

    // decompiled from Move bytecode v6
}

