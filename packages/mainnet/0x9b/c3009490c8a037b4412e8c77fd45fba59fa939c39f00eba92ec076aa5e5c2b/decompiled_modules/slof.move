module 0x9bc3009490c8a037b4412e8c77fd45fba59fa939c39f00eba92ec076aa5e5c2b::slof {
    struct SLOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOF>(arg0, 6, b"SLOF", b"Sloth+Wolf", b"SLOF=Sloth+Wolf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DLT_7_A_Kqz_400x400_5793bec832.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

