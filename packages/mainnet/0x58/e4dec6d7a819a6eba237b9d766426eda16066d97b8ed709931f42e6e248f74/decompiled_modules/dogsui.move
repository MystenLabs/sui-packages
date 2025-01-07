module 0x58e4dec6d7a819a6eba237b9d766426eda16066d97b8ed709931f42e6e248f74::dogsui {
    struct DOGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGSUI>(arg0, 9, b"DOGSUI", b"Dogs", b"To the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6ba35236-7372-4d6d-8885-40b1125e6348.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

