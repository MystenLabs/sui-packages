module 0x8c44f41c3f3d64285cfab9d1e6dac23dfa008f3bb020505df427c0f22c59ebb9::fckmuah {
    struct FCKMUAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCKMUAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCKMUAH>(arg0, 6, b"FckMuah", b"Fucking scammers", b"Shit projects gonna fck u", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731002499352.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FCKMUAH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCKMUAH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

