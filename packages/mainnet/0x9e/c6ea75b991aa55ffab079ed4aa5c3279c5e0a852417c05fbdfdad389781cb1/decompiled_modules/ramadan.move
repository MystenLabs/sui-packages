module 0x9ec6ea75b991aa55ffab079ed4aa5c3279c5e0a852417c05fbdfdad389781cb1::ramadan {
    struct RAMADAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAMADAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAMADAN>(arg0, 6, b"RAMADAN", b"Ramadan On Sui", x"52616d6164616e206f6e205375692852414d4144414e292e204e6f20736f6369616c206d656469612c206a7573742052616d6164616e206f6e20537569202852414d4144414e292e0a20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_9d63981cdf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAMADAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAMADAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

