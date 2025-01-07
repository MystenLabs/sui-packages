module 0x56851e6e2a4d547c675025585aaced30ee1cd02a75cc071c36635eddbf08327::dic {
    struct DIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIC>(arg0, 6, b"DIC", b"DONT INVEST COIN", b"DONT ENTER, WHY ENTER?? STOP!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000021123_26875d357e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

