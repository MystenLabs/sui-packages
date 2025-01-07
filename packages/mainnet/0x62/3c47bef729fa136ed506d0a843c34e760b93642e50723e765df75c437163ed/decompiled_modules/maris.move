module 0x623c47bef729fa136ed506d0a843c34e760b93642e50723e765df75c437163ed::maris {
    struct MARIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARIS>(arg0, 6, b"MARIS", b"MARIS the Screenshot", b"Maris for the win!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733284229849.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARIS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARIS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

