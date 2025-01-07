module 0xf15145da06ee93f6a80891b940790e4952f01beff2d97bcddc2028e916336394::birb {
    struct BIRB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRB>(arg0, 6, b"BIRB", b"Birb On Sui", b"FWOG emerged and brought BIRB, a Yellow and cute BIRB, more based BIRB, a BIRBED one.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002367_146830cdaf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIRB>>(v1);
    }

    // decompiled from Move bytecode v6
}

