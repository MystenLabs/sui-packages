module 0x2ba87d07fd99697c26ea937f2e2f59e330605daa8851de6369ced1c363eca7cb::twif {
    struct TWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWIF>(arg0, 6, b"TWIF", b"Trumpwifnini", b"Trump wif Nini the dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/686_F66_D1_85_F1_43_A8_95_F7_EC_511_A0_A161_B_7fcaf6363d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

