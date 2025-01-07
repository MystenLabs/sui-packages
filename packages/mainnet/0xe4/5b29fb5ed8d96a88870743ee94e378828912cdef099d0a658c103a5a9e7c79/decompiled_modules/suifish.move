module 0xe45b29fb5ed8d96a88870743ee94e378828912cdef099d0a658c103a5a9e7c79::suifish {
    struct SUIFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFISH>(arg0, 6, b"SUIFISH", b"Sui Moon Fish", b"$SUIFISH is a first legit Moon Fish on Movepump.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_77326376c6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

