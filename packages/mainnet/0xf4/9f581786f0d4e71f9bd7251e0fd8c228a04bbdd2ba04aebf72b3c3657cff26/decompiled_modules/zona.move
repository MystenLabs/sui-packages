module 0xf49f581786f0d4e71f9bd7251e0fd8c228a04bbdd2ba04aebf72b3c3657cff26::zona {
    struct ZONA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZONA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZONA>(arg0, 6, b"ZONA", b"Zona Survival", b"Part of the ZONA project supporting the $ZONA coin, places players in classic Russian prison situations. Make critical decisions, build your reputation, and increase your influence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732571188354.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZONA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZONA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

