module 0x41cead424a321baf37721ceb69d33616f645c4eeab32980507d714fd64f76f8f::lbl {
    struct LBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LBL>(arg0, 6, b"LBL", b"Leo Bull", b"King of all memes in web2 + meme trend in crypto web3, a new one for SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cryptoleo_svg_f741a6eaf1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LBL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

