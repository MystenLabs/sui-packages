module 0x4ce34bc38ac82f3eb81e460b578680110ec126dc6a9741935c0073a8fed5230::tknz {
    struct TKNZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: TKNZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TKNZ>(arg0, 6, b"TKNZ", b"Tokenizator", b"Join the crypto revolution with Tokenizator's PinkSale FairLaunch. Dive into a tax-free opportunity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_0ff665cb10.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TKNZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TKNZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

