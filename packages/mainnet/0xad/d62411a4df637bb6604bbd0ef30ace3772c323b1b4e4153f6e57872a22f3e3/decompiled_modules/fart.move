module 0xadd62411a4df637bb6604bbd0ef30ace3772c323b1b4e4153f6e57872a22f3e3::fart {
    struct FART has drop {
        dummy_field: bool,
    }

    fun init(arg0: FART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FART>(arg0, 6, b"FART", b"FART SOL", b"SOLANA IS FART, SUI TO THE MOON. LET'S DO COMMUNITY BASED PROJECT.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731411048151.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FART>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FART>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

