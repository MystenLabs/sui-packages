module 0x7fe94c83e4f91657e4179196c13feaf3932f3ad57f8f3021b3c70d0ebc333ea::apprentice {
    struct APPRENTICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: APPRENTICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APPRENTICE>(arg0, 6, b"Apprentice", b"The Apprentice", b"Official Memecoin of The Apprentice.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Rh5lbcov_400x400_bb690b5fda.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APPRENTICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APPRENTICE>>(v1);
    }

    // decompiled from Move bytecode v6
}

