module 0xdae9c077321a68adc944e1cc34d6611569eaa58cd94a5ef3458178fbe9f2739c::popneiro {
    struct POPNEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPNEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPNEIRO>(arg0, 6, b"POPNEIRO", b"Pop Neiro", b"POPNEIRO WAS INSPIRED FROM NEIRO THE DOG AND OATMEAL THE POPCAT. WHAT WOULD BE IF THE TWO POWERS OF MEMES WERE COMBINED. IF YOU MISS POPCAT AND NEIRO THIS IS THE BEST TIME TO JOIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_09_at_09_28_16_644b2a2f71.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPNEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPNEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

