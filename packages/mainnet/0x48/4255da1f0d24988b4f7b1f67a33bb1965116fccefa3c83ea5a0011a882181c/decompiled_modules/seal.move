module 0x484255da1f0d24988b4f7b1f67a33bb1965116fccefa3c83ea5a0011a882181c::seal {
    struct SEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEAL>(arg0, 6, b"Seal", b"The Seal", b"We Silly, We Sealy, We Seal ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_15_23_27_52_50eaf00a4a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

