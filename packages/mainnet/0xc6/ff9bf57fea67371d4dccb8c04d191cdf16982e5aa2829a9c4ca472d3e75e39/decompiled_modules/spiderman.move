module 0xc6ff9bf57fea67371d4dccb8c04d191cdf16982e5aa2829a9c4ca472d3e75e39::spiderman {
    struct SPIDERMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPIDERMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPIDERMAN>(arg0, 9, b"SPIDERMAN", b"SPIDER", b"The great Hero of our metropolis starts with building a very strong wax (community) that can lift any thing from ground to infinity heights. And we have it at WAVES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b029c955-aff5-4289-a554-3804f3709e88.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPIDERMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPIDERMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

