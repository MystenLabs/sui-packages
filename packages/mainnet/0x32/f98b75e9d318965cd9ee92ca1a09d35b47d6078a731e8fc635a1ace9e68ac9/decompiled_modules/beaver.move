module 0x32f98b75e9d318965cd9ee92ca1a09d35b47d6078a731e8fc635a1ace9e68ac9::beaver {
    struct BEAVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAVER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAVER>(arg0, 6, b"BEAVER", b"SUI BEAVER", b"Beaver on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BEAVER_65c43a8bdd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAVER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEAVER>>(v1);
    }

    // decompiled from Move bytecode v6
}

