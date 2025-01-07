module 0x7b289a7a97a6327119a724edfa618fac8a2f3cc5e4fa287a27e3cdb6f49c64c0::sexy {
    struct SEXY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<SEXY>(arg0, 6, b"SEXY", b"TODO: Fill this in (name of the coin)", b"TODO: Fill this in (description of the coin)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"TODO: Fill this in (icon of the coin)")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEXY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEXY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<SEXY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

