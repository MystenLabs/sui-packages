module 0xd9fff4e51c2401e0a21824109df52f1bda7e640fe36d51e33681d5ef30ec5d20::lmaoburbur {
    struct LMAOBURBUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: LMAOBURBUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LMAOBURBUR>(arg0, 9, b"LMAOBURBUR", b"Hihihehe", b"Bdjeendndnn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/efed31e1-16d0-4b7b-a08f-0a07bceda75e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LMAOBURBUR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LMAOBURBUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

