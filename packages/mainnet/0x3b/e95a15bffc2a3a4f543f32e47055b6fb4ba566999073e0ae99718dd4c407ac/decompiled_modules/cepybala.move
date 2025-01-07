module 0x3be95a15bffc2a3a4f543f32e47055b6fb4ba566999073e0ae99718dd4c407ac::cepybala {
    struct CEPYBALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CEPYBALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CEPYBALA>(arg0, 6, b"Cepybala", b"Cepybala Suibala", x"57656c636f6d6520746f204365707962616c612e200a57652061726520746865206e65787420746f70206d656d65636f696e206f6e20535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/capybl_2a59707330.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CEPYBALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CEPYBALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

