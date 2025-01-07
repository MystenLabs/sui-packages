module 0x53b24feec90d4361ada1e1c3396a7e2d29737f9493b6b9a73e63f0adc14df74::apusui {
    struct APUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: APUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APUSUI>(arg0, 6, b"APUSUI", b"ApuSui", b"Apu on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_ohne_Titel_5_png_6d4454082f.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APUSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APUSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

