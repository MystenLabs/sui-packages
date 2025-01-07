module 0xc40f13dbfdd5b8b65ecc99b4e33af168139bdb7ca9850c74a0765c3614872057::asnd {
    struct ASND has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASND, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ASND>(arg0, 6, b"ASND", b"Ascend", b"The SUI coin that encapsulates perseverance, grit, fortitude, wealth, personal development, and pursuit of happiness ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000007128_8a7c9a6c51.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ASND>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASND>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

