module 0x21ffa0cf76285ce657de63bc9deb23352ee45ce53522e19bcff1c092cfea239a::moon {
    struct MOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOON>(arg0, 6, b"MOON", b"Just to the moon", b"We just believe in the pump, the first rule is that after your purchase, you cannot sell for the next 25 transactions. If we follow this rule, we will fly to the moon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/raskraska_kosmos_dlya_malyshej_012_3425784223_e750d2a5c6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

