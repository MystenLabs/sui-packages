module 0x569ccf3cb244099ba21d7660eb0255cf03b5ef294695d916b1dfe90b1bff610d::osak {
    struct OSAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAK>(arg0, 6, b"OSAK", b"Osaka Protocol", b"Where true decentralization is born again. $OSAK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OSAKA_eb0d22be0b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OSAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

