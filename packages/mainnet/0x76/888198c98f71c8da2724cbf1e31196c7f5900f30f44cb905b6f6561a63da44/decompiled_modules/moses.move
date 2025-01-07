module 0x76888198c98f71c8da2724cbf1e31196c7f5900f30f44cb905b6f6561a63da44::moses {
    struct MOSES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOSES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOSES>(arg0, 6, b"Moses", b"Sui Moses", b"Parting the seas of Sui with $MOSES!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Moses_f7b6838840.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOSES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOSES>>(v1);
    }

    // decompiled from Move bytecode v6
}

