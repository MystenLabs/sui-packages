module 0x5493f9f3afae82bfd6cfcf71d6fc016afebbf1df186e267c7515e1f9065aafcf::sfishs {
    struct SFISHS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFISHS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFISHS>(arg0, 6, b"SFISHS", b"SFISH", b"I am Staring at you ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_11_212659198_d4a9a059cd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFISHS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFISHS>>(v1);
    }

    // decompiled from Move bytecode v6
}

