module 0xda22b256529790da43c1b73a0b597d966cd2e24f5f6097f25a1073922867fb0f::havelyana {
    struct HAVELYANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAVELYANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAVELYANA>(arg0, 6, b"HAVELYANA", b"Havelyana", b"Exploring the unknown through abstract art inspired by my DMT journey. A visual narrative of transcendence, perception, and self discovery.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000019479_cb61d4a65d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAVELYANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAVELYANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

