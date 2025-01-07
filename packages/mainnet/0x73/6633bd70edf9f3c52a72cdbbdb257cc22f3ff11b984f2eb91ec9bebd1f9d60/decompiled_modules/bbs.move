module 0x736633bd70edf9f3c52a72cdbbdb257cc22f3ff11b984f2eb91ec9bebd1f9d60::bbs {
    struct BBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBS>(arg0, 6, b"BBS", b"BluBolz", b"is so unfair... Nobody want to touch BluBolz.. So much simping for nothing.. It hurts.. DEX will be paid at KOTH, ads will be paid on raydium... This is the new META", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1712_70570a85e4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

