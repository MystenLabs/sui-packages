module 0x316c7e0bc0533228387fcbafb55325a0aaaf7e43b1028e2821e5aee6aa3fee95::ssr {
    struct SSR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSR>(arg0, 6, b"SSR", b"SUI STRATEGIC RESERVE", b"S.S.R - Sui Strategic Reserve is a project on the Sui blockchain focused on strengthening the ecosystem by managing digital assets to enhance growth, liquidity, and sustainability.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ssr_logo_new_new_669f5730cc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSR>>(v1);
    }

    // decompiled from Move bytecode v6
}

