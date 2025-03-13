module 0xfb9ce7222d3dda427263c1d03d6da7eb5ee6a76ad1320a0f2794fb5b49090a58::bossing {
    struct BOSSING has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSSING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSSING>(arg0, 9, b"BOSSING", b"Malupiton", b"this is not a company, this is a popular person and  meme from FB.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/383823e0-d947-4dc0-806c-6dbaed3c8531.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSSING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOSSING>>(v1);
    }

    // decompiled from Move bytecode v6
}

