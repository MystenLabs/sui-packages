module 0x99c6eedda46ef45ac6fc1ec73f5282416f30c338fee5a39befcb85f75244398c::tereza {
    struct TEREZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEREZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEREZA>(arg0, 6, b"TEREZA", b"Tereza AI", b"Fully autonomous on chain VC Agent.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733704823306.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEREZA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEREZA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

