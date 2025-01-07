module 0xb42021a322433a05eceb0e95cc9e2eaefc99f43b5afb8680c51b4e3b9fede0dc::garfield {
    struct GARFIELD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GARFIELD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GARFIELD>(arg0, 6, b"GARFIELD", b"GARFIELD SUI", b"ARFIELD idea on pop cultural comic named Garfield. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/N2_Cnl5_UV_400x400_a6662e5fd0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARFIELD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GARFIELD>>(v1);
    }

    // decompiled from Move bytecode v6
}

