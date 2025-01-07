module 0x39708f3181e3ceb56a2d4ec650bc9d531dafba456c7953613be1b40806ee5823::sb {
    struct SB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SB>(arg0, 6, b"SB", b"Polar Bear by PhillipBankss", b"Polar Bear $SB is the character of PhillipBankss the creator of CHILLGUY. He didnt receive any royalty from his memecoin. We are going to change it and make justice for the artist", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241204_122456_788_b590f11980.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SB>>(v1);
    }

    // decompiled from Move bytecode v6
}

