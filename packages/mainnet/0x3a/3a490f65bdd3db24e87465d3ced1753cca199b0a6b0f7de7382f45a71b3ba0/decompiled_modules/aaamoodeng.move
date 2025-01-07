module 0x3a3a490f65bdd3db24e87465d3ced1753cca199b0a6b0f7de7382f45a71b3ba0::aaamoodeng {
    struct AAAMOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAMOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAMOODENG>(arg0, 6, b"aaaMOODENG", b"SUI aaaMOODENG", b"AAAAAAAAAAAAAA MOOOOOOOOOOOOOOO DEEEEEEEEEEEEEEEEEEEENG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AAAMOODENG_5ff8224daa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAMOODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAMOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

