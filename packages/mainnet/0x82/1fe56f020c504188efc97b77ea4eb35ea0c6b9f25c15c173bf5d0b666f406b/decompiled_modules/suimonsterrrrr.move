module 0x821fe56f020c504188efc97b77ea4eb35ea0c6b9f25c15c173bf5d0b666f406b::suimonsterrrrr {
    struct SUIMONSTERRRRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMONSTERRRRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMONSTERRRRR>(arg0, 6, b"SuiMonsterrrrr", b"Sui Monsterrrr", x"546865206d6f737420706f77657266756c206d656d6520746f6b656e20696e205375690a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1234124e1_3a230bbfe0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMONSTERRRRR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMONSTERRRRR>>(v1);
    }

    // decompiled from Move bytecode v6
}

