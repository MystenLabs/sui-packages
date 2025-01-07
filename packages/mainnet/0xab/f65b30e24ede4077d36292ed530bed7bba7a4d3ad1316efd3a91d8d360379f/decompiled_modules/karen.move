module 0xabf65b30e24ede4077d36292ed530bed7bba7a4d3ad1316efd3a91d8d360379f::karen {
    struct KAREN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAREN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAREN>(arg0, 6, b"KAREN", b"KAREN ON SUI", b"Excuseeeee me, Can you turn the music down? I'm going to call the police. SHUUUUUUT UP FKNNNN KAREN!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/KAREN_61c38c19c8_a1da783e2d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAREN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAREN>>(v1);
    }

    // decompiled from Move bytecode v6
}

