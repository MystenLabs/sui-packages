module 0xfa7e5ac93baf3ad8f06201b7484c96e15290a9dd448bed9f233d1c079487adeb::piopsui {
    struct PIOPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIOPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIOPSUI>(arg0, 6, b"PIOPSUI", b"PIOP SUI", b"Official mascot of $PIOPSUI chain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_11_183351751_ff30977dba.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIOPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIOPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

