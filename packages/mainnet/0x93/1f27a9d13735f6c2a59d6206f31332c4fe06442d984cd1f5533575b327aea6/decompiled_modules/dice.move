module 0x931f27a9d13735f6c2a59d6206f31332c4fe06442d984cd1f5533575b327aea6::dice {
    struct DICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DICE>(arg0, 6, b"Dice", b"DICE", b"THE LUCKIEST DICE ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dice_2536d923e7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DICE>>(v1);
    }

    // decompiled from Move bytecode v6
}

