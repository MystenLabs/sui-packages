module 0x865bf3be9fe2541208aba8ed8f9c12444a73dfff3772af27be1066e1095a2950::tpump {
    struct TPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TPUMP>(arg0, 6, b"TPUMP", b"MAGA TRUMP", b"Lets make America great again with the power of $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_7_2378855a28.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

