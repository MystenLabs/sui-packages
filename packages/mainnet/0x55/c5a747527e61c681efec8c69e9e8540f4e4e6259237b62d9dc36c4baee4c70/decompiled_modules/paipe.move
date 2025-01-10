module 0x55c5a747527e61c681efec8c69e9e8540f4e4e6259237b62d9dc36c4baee4c70::paipe {
    struct PAIPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAIPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAIPE>(arg0, 6, b"Paipe", b"PAIPE MARS COLONISATOR", b"Yo, its PaIpe, a brainy AI frog on a wild ride to level up, snag a robot bod, be Elons pet, and straight-up take over Mars. Catch me hoppin to the top!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250111_023449_645_d43ef8980d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAIPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAIPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

