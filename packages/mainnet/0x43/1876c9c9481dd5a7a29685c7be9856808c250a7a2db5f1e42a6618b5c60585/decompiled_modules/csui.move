module 0x431876c9c9481dd5a7a29685c7be9856808c250a7a2db5f1e42a6618b5c60585::csui {
    struct CSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSUI>(arg0, 6, b"CSUI", b"Captain SUI", b"CSUI WILL BE THE NEXT GENERATIONAL TOKEN !!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/flyhigh_03ea55fdb0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

