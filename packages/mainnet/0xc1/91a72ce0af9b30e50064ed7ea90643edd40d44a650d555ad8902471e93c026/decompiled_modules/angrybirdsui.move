module 0xc191a72ce0af9b30e50064ed7ea90643edd40d44a650d555ad8902471e93c026::angrybirdsui {
    struct ANGRYBIRDSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGRYBIRDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANGRYBIRDSUI>(arg0, 6, b"Angrybirdsui", b"Angry bird sui", x"0a57656c636f6d6520746f20746865206c6567656e6461727920416e677279204269726473207375692020636f6d6d756e697479202c77652077696c6c206c6561642074686520776179202c6c65742773206a6f696e20666f72636573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241013_215744_871_c9d4436731.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANGRYBIRDSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANGRYBIRDSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

