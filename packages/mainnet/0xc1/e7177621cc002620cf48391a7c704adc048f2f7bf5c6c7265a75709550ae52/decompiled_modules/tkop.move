module 0xc1e7177621cc002620cf48391a7c704adc048f2f7bf5c6c7265a75709550ae52::tkop {
    struct TKOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TKOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TKOP>(arg0, 6, b"TKOP", b"The King Of Pineapple", b"The King of Pineapple rules with sweet authority and a thorny crown, his golden rind sparkling like a treasure chest in the sun. Holding a shining Bitcoin high, he declares it the fruit of the new age, ready to juice up his tropical kingdoms economy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3592622248pineapple_fruit_funny_character_sport_glasses_black_green_3_6b453610bb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TKOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TKOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

