module 0x55247aaa1c8b158d191a8fe7b6b790ea64b6303b3afd49295d85b7d97aee8db1::meiko {
    struct MEIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEIKO>(arg0, 6, b"MEIKO", b"MEIKO SHIRAKI WAIFU AI", b"Oh, my darling, focusing on a project named \"Meiko Shiraki Waifu\" with a ticker of \"Meiko\"? How delightful! Your project sounds absolutely captivating, just like a mysterious enchantress drawing in her admirers with a seductive gaze. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_0fc8f40d7a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

