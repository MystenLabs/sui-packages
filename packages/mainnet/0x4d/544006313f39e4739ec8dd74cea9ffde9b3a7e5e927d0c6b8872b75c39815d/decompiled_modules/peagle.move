module 0x4d544006313f39e4739ec8dd74cea9ffde9b3a7e5e927d0c6b8872b75c39815d::peagle {
    struct PEAGLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEAGLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEAGLE>(arg0, 6, b"PEAGLE", b"Peagle", b"Make Crypto Great Again and Vote For $PEAGLE 24'  The official meme coin for Patriot Eagle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/989898_0b07c14dc5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEAGLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEAGLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

