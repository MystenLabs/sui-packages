module 0x1575f8807919d396360a094d6c01b07d73eadbca3e9d28d666cf053a476f3a21::pikka {
    struct PIKKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKKA>(arg0, 6, b"Pikka", b"PikaSUI", b"PikaSUI is here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiball_1911897181.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIKKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

