module 0x59108f6bb8a0a833844ed5cb6f8669706d3d18a454b7bcf71ff9584e072b4c4e::dorky {
    struct DORKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORKY>(arg0, 6, b"Dorky", b"DorkySui", b"For the nerds, the misfits, and the moonshot dreamers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_16_074301675_7037d1b65f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DORKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

