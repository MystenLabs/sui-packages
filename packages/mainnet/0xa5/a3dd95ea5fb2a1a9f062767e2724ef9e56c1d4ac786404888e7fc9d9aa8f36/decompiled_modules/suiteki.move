module 0xa5a3dd95ea5fb2a1a9f062767e2724ef9e56c1d4ac786404888e7fc9d9aa8f36::suiteki {
    struct SUITEKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITEKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITEKI>(arg0, 6, b"Suiteki", b"Suiteki Ocean", b"Meet Suiteki, the meme thats making a splash on the SUI blockchain. In Japanese, Suiteki means water droplet, and this meme captures the essence of water in both its name and spirit.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730958919416.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITEKI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITEKI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

