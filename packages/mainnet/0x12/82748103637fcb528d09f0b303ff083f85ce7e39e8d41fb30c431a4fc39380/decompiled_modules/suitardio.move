module 0x1282748103637fcb528d09f0b303ff083f85ce7e39e8d41fb30c431a4fc39380::suitardio {
    struct SUITARDIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITARDIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITARDIO>(arg0, 6, b"Suitardio", b"suitardio420lfgwagmi", b"WE ARE ALL SUITARDIO WAGMI LFG SUI SEASON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_01_10_05_35f83bfd44.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITARDIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITARDIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

