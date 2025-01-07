module 0xf9670e501e79140ffe8862418e97bf5b4eee5ac52e7899e707dfe59ce62de0c0::lulz {
    struct LULZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: LULZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LULZ>(arg0, 9, b"LULZ", b"LULZcoin", b"Created for maximum hilarity & cheekiness, LULZcoin is all about spreading good vibes and goofy moments across the blockchain universe.  Whether you're sharing memes, trolling in discord, or just bantering on X, LULZcoin is the currency of the Internet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/61f0bc4b-1abc-432a-9c71-31c859e7e0ac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LULZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LULZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

