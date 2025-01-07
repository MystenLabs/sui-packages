module 0x67684bca74547e299dd1a34376cf9e0351ede10b67d1a8c7a9ad3520c0acdd19::pelf {
    struct PELF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PELF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PELF>(arg0, 6, b"PELF", b"Pelfort", b"The Wolf of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_4_debc4a2bd9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PELF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PELF>>(v1);
    }

    // decompiled from Move bytecode v6
}

