module 0xbcfc4d5688971a865e0d5fb700ca3d1e5cb3a0537a649ff275ea0050d07431df::birb {
    struct BIRB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRB>(arg0, 9, b"BIRB", b"BIRB SUI", b"FWOG emerged and brought BIRB, a Yellow and cute BIRB, more based BIRB, a BIRBED one. BIRB it.  Website: https://birbsui.website/ Twitter: https://x.com/BirbSui Telegram: https://t.me/BirbSui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BIRB>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIRB>>(v1);
    }

    // decompiled from Move bytecode v6
}

