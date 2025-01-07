module 0xa4a84c4e29a6a0e267b79b1b1daf1e5a339f963cc9296cbd2ceaecc92bfd6952::smaga {
    struct SMAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMAGA>(arg0, 6, b"SMAGA", b"SUI MAGA", b"Donald Conquers America, one meme at a time on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730959319046.56")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMAGA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMAGA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

