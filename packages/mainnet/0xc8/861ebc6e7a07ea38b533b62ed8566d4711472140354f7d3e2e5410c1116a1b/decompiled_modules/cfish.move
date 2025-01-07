module 0xc8861ebc6e7a07ea38b533b62ed8566d4711472140354f7d3e2e5410c1116a1b::cfish {
    struct CFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CFISH>(arg0, 6, b"CFISH", b"Cat The Fish", b"Splashing around the Sui chain like it owns the pond", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Capa_10_5d7b35035c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

