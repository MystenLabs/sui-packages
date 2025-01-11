module 0xe34e80d7d0c907175808652b5c7ef5ec531656eda2cb715e9952f011944db7d0::lamar {
    struct LAMAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAMAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMAR>(arg0, 6, b"LAMAR", b"Lamar Jackson coin", b"A meme dedicated to Baltimore Ravens MVP quarterback Lamar Jackson.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736637383572.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAMAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAMAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

