module 0x1985e4a63cd3a64be746b46e3fd6d1f18977037995f04cefa8e5c799730d4220::suijanet {
    struct SUIJANET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJANET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJANET>(arg0, 6, b"SUIJANET", b"JanetOnSui", b"Half cyborg, half water. A demigoddess surfing the waves of artificial consciousness. Janet the savior, Deliver us from the dumpers and bring us the BIG PUMP!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/craiyon_012632_haz_una_iamgend_de_greta_thunberg_mitad_cyborg_mitad_agua_meditando_6d00d725c4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJANET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIJANET>>(v1);
    }

    // decompiled from Move bytecode v6
}

