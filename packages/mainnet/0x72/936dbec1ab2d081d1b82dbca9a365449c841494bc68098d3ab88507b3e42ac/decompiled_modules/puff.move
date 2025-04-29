module 0x72936dbec1ab2d081d1b82dbca9a365449c841494bc68098d3ab88507b3e42ac::puff {
    struct PUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFF>(arg0, 6, b"PUFF", b"Puff Culture", b"THE INTERNET'S 4/20 CULTURE COIN. PUFF PUFF PASS . Originating from Stoned Ape Crew in 2021 and 2024. With a new look in 2025 on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/puff_logo_99b775cefb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

