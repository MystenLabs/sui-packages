module 0x7ad48364c7905a67822558b47336373f37f478905d8a381c65e989924f545b85::urus {
    struct URUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: URUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<URUS>(arg0, 6, b"URUS", b"Lamborghini Urus", b"Me when 2 SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/custom_2022_lambo_urus_feels_like_a_big_blue_baby_sounds_like_an_akrapovic_rascal_6_d2a5ba3e23.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<URUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<URUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

