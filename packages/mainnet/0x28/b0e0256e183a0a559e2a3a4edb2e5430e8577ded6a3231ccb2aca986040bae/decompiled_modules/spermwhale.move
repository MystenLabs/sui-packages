module 0x28b0e0256e183a0a559e2a3a4edb2e5430e8577ded6a3231ccb2aca986040bae::spermwhale {
    struct SPERMWHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPERMWHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPERMWHALE>(arg0, 6, b"Spermwhale", b"Spermwhale of Sui", b"The oceans apex predator has arrived on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_109e5c9d1e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPERMWHALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPERMWHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

