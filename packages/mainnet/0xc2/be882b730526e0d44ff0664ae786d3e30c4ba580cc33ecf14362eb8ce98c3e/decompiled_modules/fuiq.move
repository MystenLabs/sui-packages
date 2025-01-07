module 0xc2be882b730526e0d44ff0664ae786d3e30c4ba580cc33ecf14362eb8ce98c3e::fuiq {
    struct FUIQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUIQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUIQ>(arg0, 6, b"FUIQ", b"Fuck You I Quit", b"The MArket is a MESS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_13_10_47_41_eb7b055238.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUIQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUIQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

