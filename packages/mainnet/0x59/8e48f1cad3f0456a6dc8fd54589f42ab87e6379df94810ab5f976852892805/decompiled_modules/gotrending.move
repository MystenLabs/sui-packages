module 0x598e48f1cad3f0456a6dc8fd54589f42ab87e6379df94810ab5f976852892805::gotrending {
    struct GOTRENDING has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOTRENDING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOTRENDING>(arg0, 6, b"GOTRENDING", b"$GOAT IS TRENDING", b"$GOAT IS TRENDING ON DEX AND IT IS STILL LOOKING EARLY! CHECK THIS OUT: 0x552d40b65008e73ee9062dc397f5428dc0ef668eabc832c64d956b9c214cfe37::goat::GOAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GOAT_Logo_fc44bf98e7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOTRENDING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOTRENDING>>(v1);
    }

    // decompiled from Move bytecode v6
}

