module 0x9474311f450167f78d1722a01b5b0795cbcec4356a59b2a4986aa5d6bede531d::roost {
    struct ROOST has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROOST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROOST>(arg0, 6, b"ROOST", b"Roost Coin", b"$ROOST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gq_Rdpfyd_400x400_6f243b2c5e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROOST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROOST>>(v1);
    }

    // decompiled from Move bytecode v6
}

