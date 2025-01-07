module 0x88fd7d72a2c9e8f3152882b75945cda54fe635db91e0cf7a5c76ca5ea653a580::rsui {
    struct RSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RSUI>(arg0, 6, b"RSUI", b"Red Sui", b"Red Sui on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Ei3_Nfa_AAAL_6ta_7fae2f9fea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

