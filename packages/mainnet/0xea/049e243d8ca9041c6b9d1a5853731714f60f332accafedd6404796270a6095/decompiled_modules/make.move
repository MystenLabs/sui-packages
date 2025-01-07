module 0xea049e243d8ca9041c6b9d1a5853731714f60f332accafedd6404796270a6095::make {
    struct MAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAKE>(arg0, 6, b"MAKE", b"Make America Great Again", b"Trump began using the slogan formally on November 7, 2012, the day after Barack Obama won his re-election against Mitt Romney. Trump used the slogan in an August 2013 interview with Jonathan Karl. By his own account, he first considered \"We Will Make America Great\", but did not feel like it had the right \"ring\" to it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0189_eb2a068c17.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

