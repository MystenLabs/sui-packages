module 0xa14bb9cb09e73b8e422d431cdf8fa3b38683d6a946d52f8b9eec957426bcb17b::sfinpe {
    struct SFINPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFINPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFINPE>(arg0, 6, b"SFINPE", b"SUI FINPE", b"I am SFINPE. the freest clownfish Or Sometimes also been recognised as a frog.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_03_00_48_18_ecce412adf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFINPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFINPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

