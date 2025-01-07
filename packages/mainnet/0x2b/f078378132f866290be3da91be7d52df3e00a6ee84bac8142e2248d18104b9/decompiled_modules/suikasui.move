module 0x2bf078378132f866290be3da91be7d52df3e00a6ee84bac8142e2248d18104b9::suikasui {
    struct SUIKASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKASUI>(arg0, 6, b"SUIKASUI", b"SUIKA", b"the sweetest meme token on the Sui blockchain! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_14_202837994_b70278baac.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

