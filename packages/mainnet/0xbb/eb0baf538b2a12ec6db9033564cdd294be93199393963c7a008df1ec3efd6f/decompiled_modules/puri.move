module 0xbbeb0baf538b2a12ec6db9033564cdd294be93199393963c7a008df1ec3efd6f::puri {
    struct PURI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PURI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PURI>(arg0, 6, b"PURI", b"Puri Sui", x"506f77657220746f20746865205055524921205055524920666f72207468652050656f706c65210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/combined_image_a7b6306078.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PURI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PURI>>(v1);
    }

    // decompiled from Move bytecode v6
}

