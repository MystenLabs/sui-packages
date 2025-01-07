module 0x13b0c80ffbfb0e7a15ac74ffcbda48e32eebff39c3aec2a2e1258062a968001b::goat {
    struct GOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOAT>(arg0, 6, b"GOAT", b"Greatest Of All Time - $GOAT", b"The Greatest Meme Of All Time have just already launched on CETUS. x100 Potential on this CA: 0x552d40b65008e73ee9062dc397f5428dc0ef668eabc832c64d956b9c214cfe37::goat::GOAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GOAT_Logo_d32938e56b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

