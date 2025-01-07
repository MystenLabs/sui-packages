module 0x4d5f57d038bb115a764006bde715f25006d4f94fcc5dfa60d25af6bd109604e8::pmodeng {
    struct PMODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PMODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PMODENG>(arg0, 6, b"PMODENG", b"PIXEL MODENG", b"Meet Moo Deng, the adorable baby pixel pygmy hippo whos quickly become the SUI favorite animal.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_00_16_19_347c523660.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PMODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PMODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

