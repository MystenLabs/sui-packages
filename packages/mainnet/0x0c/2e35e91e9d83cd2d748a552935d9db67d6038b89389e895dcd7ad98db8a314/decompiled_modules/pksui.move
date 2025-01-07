module 0xc2e35e91e9d83cd2d748a552935d9db67d6038b89389e895dcd7ad98db8a314::pksui {
    struct PKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKSUI>(arg0, 6, b"PKSUI", b"PIKASUI", b"Is a memecoin created for fun the community of tubos and sui lovers based in pokemon series.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731466751142.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PKSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

