module 0x556887865181d56c4f12b067abb31e774b0b7f8107ab65cb4e909c193640ede6::annsk {
    struct ANNSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANNSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANNSK>(arg0, 6, b"ANNSK", b"Annubiskate", b"Welcome to AnubisSkate!  Immerse yourself in the world of our favorite god dog doing incredible tricks on his board.    Skateboarding and Egyptian mythology together like never before! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_9a01359a29.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANNSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANNSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

