module 0xe04bf69746d32435d000683469533be4d569756bed4771d1b669cbc097d4ccd5::skibidi {
    struct SKIBIDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKIBIDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKIBIDI>(arg0, 6, b"skibidi", b"skibidi", b"skibidi pair launch on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmSepBCMZvAua6MCrbAKm-8yn0rI3IQLEo2A&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SKIBIDI>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKIBIDI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKIBIDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

