module 0x91dde9767f64464da397aaf60c3d72a54ea58ea408a4ee932a1092d7d022d9fa::dicky {
    struct DICKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DICKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DICKY>(arg0, 6, b"Dicky", b"Handsomeguyinthetown", b"Handsomeguy in the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732212071575.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DICKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DICKY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

