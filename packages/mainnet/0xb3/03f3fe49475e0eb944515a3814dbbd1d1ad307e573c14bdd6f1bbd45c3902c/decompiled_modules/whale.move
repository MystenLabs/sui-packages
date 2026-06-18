module 0xb303f3fe49475e0eb944515a3814dbbd1d1ad307e573c14bdd6f1bbd45c3902c::whale {
    struct WHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALE>(arg0, 6, b"WHALE", b"SuiWhale", b"Graduated on SuiWhale", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suiwhale.live/api/images/9ae746a1-28ec-4f7d-abda-f30886a3718e.jpg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHALE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

