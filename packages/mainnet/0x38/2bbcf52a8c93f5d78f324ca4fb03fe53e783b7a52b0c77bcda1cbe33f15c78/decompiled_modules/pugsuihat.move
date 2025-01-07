module 0x382bbcf52a8c93f5d78f324ca4fb03fe53e783b7a52b0c77bcda1cbe33f15c78::pugsuihat {
    struct PUGSUIHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUGSUIHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGSUIHAT>(arg0, 6, b"PUGSUIHAT", b"PUGWIFSUI", b"The Pug that doesn't quit.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_12_020730251_ac92b8975a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGSUIHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUGSUIHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

