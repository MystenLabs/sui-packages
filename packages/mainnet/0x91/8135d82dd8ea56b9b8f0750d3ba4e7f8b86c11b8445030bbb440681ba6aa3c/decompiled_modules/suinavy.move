module 0x918135d82dd8ea56b9b8f0750d3ba4e7f8b86c11b8445030bbb440681ba6aa3c::suinavy {
    struct SUINAVY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINAVY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINAVY>(arg0, 6, b"SuiNavy", b"naval army of sui", b"First navel army of sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000162327_f502f9abd1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINAVY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINAVY>>(v1);
    }

    // decompiled from Move bytecode v6
}

