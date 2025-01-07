module 0x96433265f45686eabb26660003d3d4551d558eb4b60cdcb1cd9ff0af3218dd49::pumpe {
    struct PUMPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMPE>(arg0, 6, b"PUMPE", b"Trumpe Pumpe", b"Welcome to the Trumpe Pumpe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TRUMPE_PUMPE_LOGO_1000x1000_631043bf34.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

