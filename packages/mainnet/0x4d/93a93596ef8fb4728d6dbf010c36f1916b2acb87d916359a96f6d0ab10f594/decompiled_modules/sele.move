module 0x4d93a93596ef8fb4728d6dbf010c36f1916b2acb87d916359a96f6d0ab10f594::sele {
    struct SELE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SELE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SELE>(arg0, 6, b"SELE", b"Sui Sele", b"we're the biggest animals in the world $SELE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053470_38b0534afd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SELE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SELE>>(v1);
    }

    // decompiled from Move bytecode v6
}

