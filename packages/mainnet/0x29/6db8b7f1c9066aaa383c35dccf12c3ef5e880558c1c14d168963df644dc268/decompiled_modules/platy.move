module 0x296db8b7f1c9066aaa383c35dccf12c3ef5e880558c1c14d168963df644dc268::platy {
    struct PLATY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLATY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLATY>(arg0, 6, b"Platy", b"Baby Platypus", b"Just cute. And venomous. Be aware", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Baby_Platypus_06ddd7e1be.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLATY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLATY>>(v1);
    }

    // decompiled from Move bytecode v6
}

