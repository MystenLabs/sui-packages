module 0x7c799b4c49752c17141a8639418a393ac41f77b5070a17cd6eeeac03de1ada::piupiu {
    struct PIUPIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIUPIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIUPIU>(arg0, 6, b"Piupiu", b"$Piupiu on sui", b"Meet $PIUPIU, $PIUPIU is an ancient elder turtle, ruler of the deep sea world. $Piupiu is journeying across the oceans with its magical powers, able to conquer every ocean it visits. Join $Piupiu on its journey", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tttrutk_58e4a7a005.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIUPIU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIUPIU>>(v1);
    }

    // decompiled from Move bytecode v6
}

