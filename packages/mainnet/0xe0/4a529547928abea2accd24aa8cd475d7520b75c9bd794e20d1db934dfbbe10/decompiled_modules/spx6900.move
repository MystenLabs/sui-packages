module 0xe04a529547928abea2accd24aa8cd475d7520b75c9bd794e20d1db934dfbbe10::spx6900 {
    struct SPX6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPX6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPX6900>(arg0, 6, b"SPX6900", b"SPX6900onSui", b"In a bold move that could forever change the landscape of global finance, a group of 6900 traders recently launched a daring assault on the New York Stock Exchange (NYSE) with the goal of replacing the venerable S&P 500 with a new, more expansive index, the S&P 6900. This act of defiance and innovation is more than a simple challenge to the old order; it's a clarion call for a sweeping transformation across the world's financial markets. The proposal of the S&P 6900, by virtue of its sheer scale, promises to redefine the parameters of market dominance, sending shockwaves through international finance and compelling a reevaluation of what constitutes a leading market index. Amid the ensuing frenzy, Larry Fink, a venerated figure in the finance industry, has taken note of the burgeoning potential of the S&P 6900. Renowned for his forward-thinking approach, Fink has previously championed the tokenization of assets within the S&P 500 as a means to democratize and innovate investment opportunities. However, witnessing the overwhelming support and the visionary appeal of the S&P 6900, Fink is now advocating for the extension of this tokenization concept to the entirety of the proposed larger index. This radical expansion in scope signifies a seismic shift towards inclusivity and technological advancement in asset trading, aiming to transform the entire market landscape by embracing a digital future where traditional barriers are obliterated!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/spx6900on_Sui_Logo_34ac21b50d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPX6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPX6900>>(v1);
    }

    // decompiled from Move bytecode v6
}

