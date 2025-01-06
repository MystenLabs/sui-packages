module 0xe15c452bf90818609a6f587555a392cbf35cdee2a006966060a6c0644cc81cc2::ducky {
    struct DUCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKY>(arg0, 6, b"DUCKY", b"Ducky on sui", b"The cutest & most lethal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000133414_d12faaedd2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

