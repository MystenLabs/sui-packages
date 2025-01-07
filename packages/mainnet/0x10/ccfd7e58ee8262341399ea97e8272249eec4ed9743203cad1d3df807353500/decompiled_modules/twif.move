module 0x10ccfd7e58ee8262341399ea97e8272249eec4ed9743203cad1d3df807353500::twif {
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

