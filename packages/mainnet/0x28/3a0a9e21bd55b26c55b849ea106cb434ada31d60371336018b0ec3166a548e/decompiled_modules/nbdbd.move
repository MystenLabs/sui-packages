module 0x283a0a9e21bd55b26c55b849ea106cb434ada31d60371336018b0ec3166a548e::nbdbd {
    struct NBDBD has drop {
        dummy_field: bool,
    }

    fun init(arg0: NBDBD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NBDBD>(arg0, 9, b"NBDBD", b"jeken", b"hehe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/be2b8d31-b93d-4bf0-a012-c541b90623bc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NBDBD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NBDBD>>(v1);
    }

    // decompiled from Move bytecode v6
}

