module 0x482d8dc6063b4daca004d9579056050aa19c4a2dfff4536c2b6bd061f6f56a92::hopsui {
    struct HOPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPSUI>(arg0, 6, b"HOPSUI", b"HopSuiAAA", b"The first coin that pays you to hold and burns tokens at each market cap milestone!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hop_37ca28d723.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

