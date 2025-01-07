module 0x3c1b5f1960faecb5222565225ccd6f0694b28cc6a51eba989ddf16233b57c444::simsuitoken {
    struct SIMSUITOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMSUITOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMSUITOKEN>(arg0, 6, b"SimSuiToken", b"SimSui", b"The only Homer on $SUI - $SIMSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/simsiui_cb40cca40c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMSUITOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIMSUITOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

