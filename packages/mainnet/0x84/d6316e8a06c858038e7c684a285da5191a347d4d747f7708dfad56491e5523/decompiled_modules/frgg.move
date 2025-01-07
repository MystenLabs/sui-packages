module 0x84d6316e8a06c858038e7c684a285da5191a347d4d747f7708dfad56491e5523::frgg {
    struct FRGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRGG>(arg0, 6, b"FRGG", b"FROGGING SUI", b"Frogggz frogggz froggz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zzzda_97b9fd761f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

