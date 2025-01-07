module 0x2e01bb8b31c734a75ed150b232dab3b2d6adf451e17504fbe7e2943e35c59b85::suiicegirl {
    struct SUIICEGIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIICEGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIICEGIRL>(arg0, 6, b"suiiceGirl", b"Suiice", b"The Little Iceman in the Forest Iceman", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_20240926_211539_mark_via_Shell_8ca375022a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIICEGIRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIICEGIRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

