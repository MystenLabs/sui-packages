module 0xfd2dc38659d436c542b2f39968467685bb245a697a5384db16d956d247e63765::ehs {
    struct EHS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EHS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EHS>(arg0, 9, b"EHS", b"ehs", b"they them xi xer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/3f1529fb-fb7b-4e06-a743-fdf09e42346a.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EHS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EHS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

