module 0x7b7a61593f77886b9283202841c68523d2b4fb424d83f403861d9a9ee2acc4bb::susui {
    struct SUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSUI>(arg0, 6, b"SUSUI", b"SUSUI COIN", b"The sushi fish is here to stop swim and go fly to the fkn moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_pantalla_2024_09_16_205009_5e767f230d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

