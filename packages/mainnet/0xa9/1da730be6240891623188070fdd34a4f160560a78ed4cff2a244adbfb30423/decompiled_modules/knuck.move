module 0xa91da730be6240891623188070fdd34a4f160560a78ed4cff2a244adbfb30423::knuck {
    struct KNUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KNUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KNUCK>(arg0, 6, b"KNUCK", b"Knuck Knuck", b"knuck knuck we kno da wae, from uganda, for da sui world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x9796dbb33e97379d155139f7f17c41fec44a1939_0017cdfcb4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KNUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KNUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

