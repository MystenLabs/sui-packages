module 0x16c054e304bc6c7c8922fce957fce50ea986bee8f91934b6ee8bfc7a2c10e719::dok {
    struct DOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOK>(arg0, 6, b"DOK", b"Dok Universe Sui", b"I'm DOK, the coolest dog.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/prop_dab4c959f9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

