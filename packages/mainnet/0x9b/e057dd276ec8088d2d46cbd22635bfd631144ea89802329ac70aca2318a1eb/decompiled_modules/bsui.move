module 0x9be057dd276ec8088d2d46cbd22635bfd631144ea89802329ac70aca2318a1eb::bsui {
    struct BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSUI>(arg0, 6, b"BSUI", b"BTC on SUI", x"546865207072696d617279206d656d6520617420426974636f696e206f6e2053554920697320746f2068656c7020666163696c697461746520746865207573657273207369676e69666963616e746c790a200a57652061726520636f6e666964656e742074686174205375692063616e2020696d70726f76652074686520776f726c6420616e64206172652064656469636174656420746f206372656174696e672061206d6f726520696e636c757369766520616e642077656c636f6d696e6720656e7669726f6e6d656e7420666f7220616c6c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/btcsui_9e7a0a5eeb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

