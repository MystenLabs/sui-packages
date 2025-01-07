module 0x5067c2925f7099295ceb052bdf46cd8aad55f5d2f38302391648212b45b2215f::suibz {
    struct SUIBZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBZ>(arg0, 6, b"SUIBZ", b"SUIBIZA", b"Oooooh were going to SUIbiza", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIBIZA_Logo_27f402e78b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

