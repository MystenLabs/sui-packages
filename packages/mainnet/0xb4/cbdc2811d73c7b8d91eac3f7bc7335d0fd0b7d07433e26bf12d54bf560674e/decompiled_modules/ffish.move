module 0xb4cbdc2811d73c7b8d91eac3f7bc7335d0fd0b7d07433e26bf12d54bf560674e::ffish {
    struct FFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFISH>(arg0, 6, b"FFISH", b"Floating FISH", b"ITS FUCKING FLOATING FISH!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/460576891_2004270770003570_7928040288412908519_n_6d5990f33a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

