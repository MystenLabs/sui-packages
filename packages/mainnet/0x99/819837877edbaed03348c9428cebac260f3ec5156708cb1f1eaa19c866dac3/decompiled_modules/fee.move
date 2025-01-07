module 0x99819837877edbaed03348c9428cebac260f3ec5156708cb1f1eaa19c866dac3::fee {
    struct FEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEE>(arg0, 6, b"FEE", b"FEE FISH", b"FEE FISH ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A_Dx_Lk_JE_400x400_2115bd2fe7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

