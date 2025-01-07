module 0x663a172e9144cbbb432a259f2db096eabd357957d91519be3507667084f663cb::swom {
    struct SWOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWOM>(arg0, 6, b"SWOM", b"swom swom", b"Swimming cats cult on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cta_cat_e470cf257f.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

