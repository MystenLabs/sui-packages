module 0x66c7f17dbdd5070d6a70b112cff00b8d7dd90a73af20230093fdc5193cf9e6e7::memez {
    struct MEMEZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEZ>(arg0, 6, b"MEMEZ", b"Memez", b"Make Sui Meme Season Great Again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/n8_KMWY_6_400x400_d6680be987.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEMEZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

