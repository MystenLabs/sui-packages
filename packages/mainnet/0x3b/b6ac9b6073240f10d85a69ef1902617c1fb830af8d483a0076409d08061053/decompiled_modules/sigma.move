module 0x3bb6ac9b6073240f10d85a69ef1902617c1fb830af8d483a0076409d08061053::sigma {
    struct SIGMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIGMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIGMA>(arg0, 6, b"SIGMA", b"SIGMAONSUI", b"SIGMA MALES ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PHOTO_2024_10_09_10_50_49_a4d42d8a65.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIGMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIGMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

