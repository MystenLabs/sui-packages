module 0x527acc68f761809190cd64de831659ed40082689cc2bce646c08c9ec945adbe4::meowdeng {
    struct MEOWDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOWDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOWDENG>(arg0, 6, b"Meowdeng", b"Meowdeng Sui", x"546865206d6f737420766972616c206361742074686174206861732074616b656e206f76657220746865206d61726b65740a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_00_55_13_f93ffa9e1a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOWDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEOWDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

