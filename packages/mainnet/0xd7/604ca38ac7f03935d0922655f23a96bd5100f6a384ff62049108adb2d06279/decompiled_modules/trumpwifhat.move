module 0xd7604ca38ac7f03935d0922655f23a96bd5100f6a384ff62049108adb2d06279::trumpwifhat {
    struct TRUMPWIFHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPWIFHAT, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<TRUMPWIFHAT>(arg0, 8499016450929396499, b"Trumpwifhat", b"TRUMPWIFHAT", b"America Great Again", b"https://images.hop.ag/ipfs/QmWTLnu3yb7ZpSkFZdcCqD1qRb2BKEdciYN9fAJSs1SVW4", 0x1::string::utf8(b"https://x.com/trumpw1fhat"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

