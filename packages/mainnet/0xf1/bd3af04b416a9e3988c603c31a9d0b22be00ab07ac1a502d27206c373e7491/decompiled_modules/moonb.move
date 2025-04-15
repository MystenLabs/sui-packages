module 0xf1bd3af04b416a9e3988c603c31a9d0b22be00ab07ac1a502d27206c373e7491::moonb {
    struct MOONB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONB>(arg0, 6, b"MOONB", b"Moon bags", b"Grab your bags and let's moon this! No jeets, if you have to sell for burger money, do it politely without killing this chart! Dont be a douche.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie6pcq4lnokokwt2pvaa3rcesdk5bag572z2to4a2bwbxgbhuvvee")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOONB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

