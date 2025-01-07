module 0xe398fedec8557068cc32477643c5ab4211e132c3d2d795983c9377842934dd56::lol {
    struct LOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOL>(arg0, 9, b"LOL", b"LaughDolla", b"LaughDollar is the coin for those who believe the best investment is a good laugh! A fun-filled currency fueled by memes and internet jokes, reminding us that sometimes the biggest payoff is in the humor.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5cd6e573-ad8c-4403-940d-d8793122a368.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

