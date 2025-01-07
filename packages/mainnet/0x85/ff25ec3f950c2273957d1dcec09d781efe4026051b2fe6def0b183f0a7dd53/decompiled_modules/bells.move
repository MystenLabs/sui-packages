module 0x85ff25ec3f950c2273957d1dcec09d781efe4026051b2fe6def0b183f0a7dd53::bells {
    struct BELLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELLS>(arg0, 9, b"BELLS", b"Bello616", b"Bell the bell", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/254b94ec-178f-4997-983f-2f9ce4a511ec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BELLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

