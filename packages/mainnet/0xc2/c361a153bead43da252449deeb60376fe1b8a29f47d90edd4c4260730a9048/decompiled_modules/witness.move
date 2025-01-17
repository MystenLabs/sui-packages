module 0xc2c361a153bead43da252449deeb60376fe1b8a29f47d90edd4c4260730a9048::witness {
    struct WITNESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WITNESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WITNESS>(arg0, 6, b"WITNESS", b"NeoWitness", b"NeoWitnesses are a fun token project on Sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737140699549.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WITNESS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WITNESS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

