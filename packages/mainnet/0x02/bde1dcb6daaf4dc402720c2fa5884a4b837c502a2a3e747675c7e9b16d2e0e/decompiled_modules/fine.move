module 0x2bde1dcb6daaf4dc402720c2fa5884a4b837c502a2a3e747675c7e9b16d2e0e::fine {
    struct FINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FINE>(arg0, 6, b"FINE", b"Sui Is Fine", b"yea sui is fine.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_is_fine_6b69a60bab.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

