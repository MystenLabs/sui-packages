module 0x20a5b7a06e23b93f22432b02c7a8859fbfe9123bb85b2dbc36a214dae3dea6c8::beluga {
    struct BELUGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELUGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELUGA>(arg0, 6, b"BELUGA", b"Beluga on Sui", b"Beluga originated from a meme cat called Polite Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Beluga_Cat_e1714190563227_78a1f572bc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELUGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BELUGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

