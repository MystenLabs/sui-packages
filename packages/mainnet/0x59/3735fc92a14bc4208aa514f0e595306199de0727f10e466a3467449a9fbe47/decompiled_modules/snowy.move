module 0x593735fc92a14bc4208aa514f0e595306199de0727f10e466a3467449a9fbe47::snowy {
    struct SNOWY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOWY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOWY>(arg0, 6, b"SNOWY", b"SnowyBear", b"SNOWY THE BEAR!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/snowy_7452ca6c65.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOWY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOWY>>(v1);
    }

    // decompiled from Move bytecode v6
}

