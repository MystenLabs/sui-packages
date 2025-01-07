module 0x7bc097ef2f1c2168e2522221920931dd5a87c86da9f95eb592c14862ade15e8::sigma {
    struct SIGMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIGMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIGMA>(arg0, 9, b"SIGMA", b"Sigma male", b"Sigma male representation of alpha male", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5436db97-c8ec-4d69-8cdb-6b794de1b125.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIGMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIGMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

