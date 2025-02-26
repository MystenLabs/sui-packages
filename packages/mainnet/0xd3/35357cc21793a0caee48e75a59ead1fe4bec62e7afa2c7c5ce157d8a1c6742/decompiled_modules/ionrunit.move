module 0xd335357cc21793a0caee48e75a59ead1fe4bec62e7afa2c7c5ce157d8a1c6742::ionrunit {
    struct IONRUNIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: IONRUNIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IONRUNIT>(arg0, 6, b"IONRUNIT", b"ionrunit", b"he doesn't run it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1740534052144.43")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IONRUNIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IONRUNIT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

