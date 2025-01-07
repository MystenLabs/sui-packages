module 0x5a242236d4d3c62a4c379db07c2ef643324ecb88c1c7db413a888fa1d3a20f7c::carlo {
    struct CARLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARLO>(arg0, 6, b"Carlo", b"The King Carlo", b"Carlo is a clinically insane dog with a pink a**hole. You bet. But thats what makes him a legend at flipping profits.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_12_30_at_10_10_06a_am_1466ae07e3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CARLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

