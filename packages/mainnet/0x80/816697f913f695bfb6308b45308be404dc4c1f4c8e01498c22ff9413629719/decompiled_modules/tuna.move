module 0x80816697f913f695bfb6308b45308be404dc4c1f4c8e01498c22ff9413629719::tuna {
    struct TUNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUNA>(arg0, 6, b"TUNA", b"The chiweenie dog", b"Tuna belongs to water !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/famous_pets_tuna_2_6740bded37.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

