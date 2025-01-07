module 0xf72877d8661b3cc59fd1cf73ab32cf6cca83183df92da6429c77da370ae7931a::poomdeng {
    struct POOMDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOMDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOMDENG>(arg0, 6, b"POOMDENG", b"POPSUIMOON", b"POPCAT + MOONDENG = POMDENG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_15_002353218_fd738a05c7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOMDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOMDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

