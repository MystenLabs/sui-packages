module 0x7e5eb2cfc5daccb62dbed90a1c6534a324537713de52a2ce62dccb3007e02eca::boggy {
    struct BOGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOGGY>(arg0, 6, b"BOGGY", b"Boggy Token", b"We make bread, to give bread. $BOGGY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_RD_Kd_En6_400x400_0ebff87148.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

