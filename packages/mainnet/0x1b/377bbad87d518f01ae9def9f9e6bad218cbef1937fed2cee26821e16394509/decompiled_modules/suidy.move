module 0x1b377bbad87d518f01ae9def9f9e6bad218cbef1937fed2cee26821e16394509::suidy {
    struct SUIDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDY>(arg0, 6, b"SUIDY", b"Suidermen", b"King of Sweg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_Movepump_624c12f6a1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

