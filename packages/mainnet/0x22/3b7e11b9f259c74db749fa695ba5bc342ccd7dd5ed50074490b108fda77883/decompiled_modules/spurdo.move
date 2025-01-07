module 0x223b7e11b9f259c74db749fa695ba5bc342ccd7dd5ed50074490b108fda77883::spurdo {
    struct SPURDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPURDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPURDO>(arg0, 6, b"SPURDO", b"SpurdoSui", b"Drinking wine feeling fine! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/spurdo_3b3a437cae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPURDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPURDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

