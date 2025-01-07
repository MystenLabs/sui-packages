module 0xb93ec4fa0e8e806b8a388e61f2565963fd5f597cc293bdd8c4b028203fe0b340::suijrs {
    struct SUIJRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJRS>(arg0, 6, b"SuiJRS", b"JRS", b"We have been preparing for two days and finally we can meet everyone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7123_98a93e25d7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJRS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIJRS>>(v1);
    }

    // decompiled from Move bytecode v6
}

