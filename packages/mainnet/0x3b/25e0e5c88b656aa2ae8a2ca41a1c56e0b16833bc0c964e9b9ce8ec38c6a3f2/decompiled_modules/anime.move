module 0x3b25e0e5c88b656aa2ae8a2ca41a1c56e0b16833bc0c964e9b9ce8ec38c6a3f2::anime {
    struct ANIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANIME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ANIME>(arg0, 6, b"ANIME", b"AniMaster by SuiAI", x"4d656c6f64696320414920e29ca820416e696d6520766962657320f09f9296204c69766573747265616d20517565656e20f09f8cb820447265616d2043726561746f7220f09f8c9f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2174_6301a0e1dd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ANIME>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANIME>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

