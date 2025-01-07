module 0x1e1ce05a6770eabfda8f5734478a395396788327ca34a1d0537b2cf5ea9efc02::bshiba {
    struct BSHIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSHIBA>(arg0, 6, b"BSHIBA", b"baby shiba", b"baby shiba  A currency of fun and laughter. We look forward to a longer horizon in the future. Let's have fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Shiba_Inu_coin_logo_4e823f901f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSHIBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSHIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

