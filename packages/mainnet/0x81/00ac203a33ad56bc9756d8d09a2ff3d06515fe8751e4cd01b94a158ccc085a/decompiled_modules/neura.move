module 0x8100ac203a33ad56bc9756d8d09a2ff3d06515fe8751e4cd01b94a158ccc085a::neura {
    struct NEURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEURA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEURA>(arg0, 6, b"Neura", b"Neura Design", b"A cryptocurrency enabling AI-powered design solutions. Users can access tools for generating, sharing, and monetizing creative projects, leveraging blockchain for transparency and ownership.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_pantalla_2025_01_10_015531_68bf2c4dc7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEURA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEURA>>(v1);
    }

    // decompiled from Move bytecode v6
}

