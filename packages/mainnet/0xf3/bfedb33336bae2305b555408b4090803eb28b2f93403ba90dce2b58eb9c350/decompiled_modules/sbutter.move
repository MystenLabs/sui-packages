module 0xf3bfedb33336bae2305b555408b4090803eb28b2f93403ba90dce2b58eb9c350::sbutter {
    struct SBUTTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBUTTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBUTTER>(arg0, 6, b"Sbutter", b"Blue Butt On Sui", b"Dive into the wild world of Blue Butt , the memecoin on Sui for laughs, gains, and pure degen energy .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_5561c32ee9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBUTTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBUTTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

