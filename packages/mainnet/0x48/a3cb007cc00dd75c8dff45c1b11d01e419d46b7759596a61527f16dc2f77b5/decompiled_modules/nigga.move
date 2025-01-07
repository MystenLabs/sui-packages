module 0x48a3cb007cc00dd75c8dff45c1b11d01e419d46b7759596a61527f16dc2f77b5::nigga {
    struct NIGGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIGGA>(arg0, 6, b"NIGGA", b"SUI NIGGA", b"SUP NIGGA FISH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiniggablue_7faacaa884.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIGGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIGGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

