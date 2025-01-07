module 0xc9342e44955dabd7d9f20940769bb53a1bb7ede545619a017eff1190ebb12fd0::parve {
    struct PARVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PARVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PARVE>(arg0, 6, b"PARVE", b"Parve on Sui", b"The only token made by a pervert and made for perverts", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4417_4fb0e05ad7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PARVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PARVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

