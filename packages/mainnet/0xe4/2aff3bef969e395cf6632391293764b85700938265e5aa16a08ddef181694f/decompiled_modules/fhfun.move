module 0xe42aff3bef969e395cf6632391293764b85700938265e5aa16a08ddef181694f::fhfun {
    struct FHFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FHFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FHFUN>(arg0, 6, b"FHFUN", b"Fuck HFUN", b"FUCK HOPFUN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_03_034123_b58cf75118.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FHFUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FHFUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

