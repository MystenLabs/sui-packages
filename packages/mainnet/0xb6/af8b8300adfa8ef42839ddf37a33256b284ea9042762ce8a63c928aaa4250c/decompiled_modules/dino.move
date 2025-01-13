module 0xb6af8b8300adfa8ef42839ddf37a33256b284ea9042762ce8a63c928aaa4250c::dino {
    struct DINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DINO>(arg0, 6, b"DINO", b"SuiDino", b"DINO, THE MOST PREDITORY ANIMAL IN THE SUI NETWORK, IS NOW HERE WITH BOTH HIS PREDICTION AND CUTENESS.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000199129_5d7a80afb2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

