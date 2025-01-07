module 0x4e5afe76a2c3f5ed83062dd799f3ce3aac676cf06e72146b07e94444fd6b794::suibasu {
    struct SUIBASU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBASU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBASU>(arg0, 6, b"SUIBASU", b"SUIBA", b"The secret ingredient has always been a blue dog.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_12_014807124_2ffa2fcc89.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBASU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBASU>>(v1);
    }

    // decompiled from Move bytecode v6
}

