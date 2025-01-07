module 0x37518c637135b390d4345b164ae31d22e2f38c75644fe0f0a7a1b9adec7910ef::teeheehe {
    struct TEEHEEHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEEHEEHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEEHEEHE>(arg0, 6, b"TeeHeeHe", b"Tee_Hee_He", b"hi! im karan.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/THH_d83e270197.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEEHEEHE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEEHEEHE>>(v1);
    }

    // decompiled from Move bytecode v6
}

