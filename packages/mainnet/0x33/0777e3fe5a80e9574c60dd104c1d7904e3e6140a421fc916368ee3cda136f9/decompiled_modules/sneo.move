module 0x330777e3fe5a80e9574c60dd104c1d7904e3e6140a421fc916368ee3cda136f9::sneo {
    struct SNEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNEO>(arg0, 6, b"SNEO", b"SUINEO", x"5375696e656f20697320612066756e206d656d6520746f6b656e20696e7370697265642062792074686520706c6179206f6e20776f726473206265747765656e202253756e652220616e6420225375692c220a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUINEO_b6ca9f3cfc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

