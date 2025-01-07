module 0x5758cab2d836d229fa9bbb9d41cfa8a12e8e6838c3fe35d9589bce4f6ac289df::fwiz {
    struct FWIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWIZ>(arg0, 6, b"FWIZ", b"FWIZ The Frog", b"Fwiz The Frog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4847_78423be1fd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWIZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWIZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

