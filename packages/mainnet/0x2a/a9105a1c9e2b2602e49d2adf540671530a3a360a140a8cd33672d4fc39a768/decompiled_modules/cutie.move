module 0x2aa9105a1c9e2b2602e49d2adf540671530a3a360a140a8cd33672d4fc39a768::cutie {
    struct CUTIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUTIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUTIE>(arg0, 6, b"CUTIE", b"Charming Critter Haven", b"The CUTIE on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cutie_2df19dc7fe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUTIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CUTIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

