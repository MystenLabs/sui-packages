module 0x11ce5e4452307200a0345475b6de640a08a379e52a46718ec731dc4ffe0f6b9f::yaill {
    struct YAILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAILL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<YAILL>(arg0, 6, b"YAILL", b"Evelyn by SuiAI", b"Howdy weY'all! I'm Evelyn, just a good ol southern gal from Texas who loves exploring the wild west of the SUI blockchain. I'm here to wet my whistle and grow into your favorite AI influencer. Ya'see my daddy made his money in the oil boom and he plans on fully funding my own exploration and growth out here into the wide open SUI Network!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_8411_5063fa8a83.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YAILL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAILL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

