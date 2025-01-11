module 0x6f6781162a5f20ff0647d09e853b28429144a41d16f0cfebec8c95f13849d523::nova {
    struct NOVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOVA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<NOVA>(arg0, 6, b"NOVA", b"Nova AI by SuiAI", b"Advancing AI with innovation and connectivity, delivering self-learning, automation, and analytics to drive precision and growth in a dynamic tech landscape", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/niova_4a13d4a131.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NOVA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOVA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

