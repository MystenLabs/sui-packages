module 0x309749a78c2d931e4e13d33c89f61ef946ad261278ec7bf8ef32b76cd1c68011::memexi {
    struct MEMEXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEXI>(arg0, 9, b"MEMEXI", b"Memex", b"THAT GO THEN THIS WHAT WHEN THEY I DO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5faf441a-25ff-49f4-a7e7-8563c53c748f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEXI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEXI>>(v1);
    }

    // decompiled from Move bytecode v6
}

