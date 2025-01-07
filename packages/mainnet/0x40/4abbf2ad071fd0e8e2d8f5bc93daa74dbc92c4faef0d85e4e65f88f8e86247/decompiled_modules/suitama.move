module 0x404abbf2ad071fd0e8e2d8f5bc93daa74dbc92c4faef0d85e4e65f88f8e86247::suitama {
    struct SUITAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITAMA>(arg0, 6, b"SUITAMA", b"Suitama", b"One punch for the pump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000166789_acb3da8af3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

