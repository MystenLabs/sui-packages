module 0x988c00e82ed34871232794954fccb4528fd8114771ba75ee8e25873b7ca929f5::mouse {
    struct MOUSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOUSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOUSE>(arg0, 6, b"Mouse", b"MOUSE", b"THE FIRST MOUSE TOKEN IN  MOVEPUMP! LET'S DO IT!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e_36d088c1ba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOUSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOUSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

