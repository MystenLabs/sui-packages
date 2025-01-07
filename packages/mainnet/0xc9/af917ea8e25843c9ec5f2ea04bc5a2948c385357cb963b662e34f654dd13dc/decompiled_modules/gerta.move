module 0xc9af917ea8e25843c9ec5f2ea04bc5a2948c385357cb963b662e34f654dd13dc::gerta {
    struct GERTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GERTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GERTA>(arg0, 6, b"GERTA", b"Gerta", b"How dare you?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/prof_a4b41a2fb5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GERTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GERTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

