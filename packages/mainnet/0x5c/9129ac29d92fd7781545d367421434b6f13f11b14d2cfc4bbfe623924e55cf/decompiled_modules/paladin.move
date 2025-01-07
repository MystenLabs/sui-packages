module 0x5c9129ac29d92fd7781545d367421434b6f13f11b14d2cfc4bbfe623924e55cf::paladin {
    struct PALADIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PALADIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PALADIN>(arg0, 6, b"Paladin", b"go pvp", b"awc go", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tabard_b62a477079.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PALADIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PALADIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

