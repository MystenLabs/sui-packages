module 0xfcefc8d5a26229c0dfcf7e187c5cadef061c9c9eafdddef9a3f18b6c2ee517d4::bds {
    struct BDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDS>(arg0, 6, b"BDS", b"Big Dick Sun", b"Big Dick Sun: Go Big or Go Home! Embrace adventure with $BDS the meme token that defies boundaries. Join now, have fun and invest like theres no tomorrow! Check out our farming telegram mini app https://t.me/BDStoken_bot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_md_1a2d9c405a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

