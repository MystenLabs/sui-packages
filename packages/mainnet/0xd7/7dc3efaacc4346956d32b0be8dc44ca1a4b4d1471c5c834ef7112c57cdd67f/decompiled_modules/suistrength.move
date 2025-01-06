module 0xd77dc3efaacc4346956d32b0be8dc44ca1a4b4d1471c5c834ef7112c57cdd67f::suistrength {
    struct SUISTRENGTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISTRENGTH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUISTRENGTH>(arg0, 6, b"SUISTRENGTH", b"SUI STRENGTH by SuiAI", b"..SUI STRENGTH is a crypto AI agent designed to empower users with personalized workout and diet plans tailored to their fitness goals. It engages holders through weekly fitness contests, where participants can earn SUI STRENGTH tokens as rewards for their performance. The agent combines health and fitness with blockchain technology, motivating users to stay fit while earning crypto rewards.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_1948_fca105955f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUISTRENGTH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISTRENGTH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

