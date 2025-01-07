module 0x878d31bce4378c3239b215e68afc736d2af38c83c165d82d6036accb2dbdee06::pumptok {
    struct PUMPTOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPTOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMPTOK>(arg0, 6, b"PUMPTOK", b"PUMPTOKSUI", x"54696b746f6b2062757420666f72205265746172647320616e642065766572797468696e67206372617a7920676f696e67206f6e20696e2050756d7066756e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241129_070156_946_f9ef4ec071.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPTOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPTOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

