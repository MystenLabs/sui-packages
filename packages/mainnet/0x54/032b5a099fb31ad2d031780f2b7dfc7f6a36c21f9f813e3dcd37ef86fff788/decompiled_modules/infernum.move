module 0x54032b5a099fb31ad2d031780f2b7dfc7f6a36c21f9f813e3dcd37ef86fff788::infernum {
    struct INFERNUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: INFERNUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INFERNUM>(arg0, 6, b"INFERNUM", b"Infernum", b"Do you dare enter the Infernum of Faern?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/234234_b55af722d0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INFERNUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INFERNUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

