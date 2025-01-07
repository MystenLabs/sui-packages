module 0xeab0b52a8a3ad8bdc86742b0589b1c57d0f4fed61c38ca932ed22c978fc258da::tknz {
    struct TKNZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: TKNZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<TKNZ>(arg0, 6, b"TKNZ", b"Tokenizator", b"Join the crypto revolution with Tokenizator's PinkSale FairLaunch. Dive into a tax-free opportunity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_df6a47d611.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TKNZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<TKNZ>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TKNZ>>(v2);
    }

    // decompiled from Move bytecode v6
}

