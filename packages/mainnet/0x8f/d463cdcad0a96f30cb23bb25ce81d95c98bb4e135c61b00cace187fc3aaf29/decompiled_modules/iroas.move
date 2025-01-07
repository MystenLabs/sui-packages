module 0x8fd463cdcad0a96f30cb23bb25ce81d95c98bb4e135c61b00cace187fc3aaf29::iroas {
    struct IROAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IROAS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<IROAS>(arg0, 6, b"IROAS", b"Antonis", b"crypto investor", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Stigmiotypo_othonis_2024_12_06_001145_5b2ef0b53f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IROAS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IROAS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

