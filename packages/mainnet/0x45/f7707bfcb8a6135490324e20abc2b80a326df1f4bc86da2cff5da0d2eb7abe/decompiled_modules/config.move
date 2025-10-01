module 0x45f7707bfcb8a6135490324e20abc2b80a326df1f4bc86da2cff5da0d2eb7abe::config {
    public fun default_bp() : u16 {
        1000
    }

    public fun ext_permission() : u128 {
        10
    }

    public fun is_token_oshi(arg0: vector<u8>) : bool {
        0x1::string::utf8(arg0) == 0x1::string::utf8(b"0xf16656c7d417654680c9e6a67f626c2c99a7a91011c88bc50d9ccaffdc53081b::oshi::OSHI")
    }

    public fun is_token_oshisui(arg0: vector<u8>) : bool {
        0x1::string::utf8(arg0) == 0x1::string::utf8(b"0x95f9ff87d8e0640cb3369bb470761b9ec46eb0ff3cc1eed417df4fa24c853f42::oshi_sui::OSHI_SUI")
    }

    public fun is_token_sui(arg0: vector<u8>) : bool {
        0x1::string::utf8(arg0) == 0x1::string::utf8(b"0x2::sui::SUI")
    }

    public fun is_token_usdc(arg0: vector<u8>) : bool {
        0x1::string::utf8(arg0) == 0x1::string::utf8(b"0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC")
    }

    public fun max_bp() : u16 {
        10000
    }

    public fun nft_image_url() : vector<u8> {
        b"https://www.bravefrontierversus.com/ja/assets/images/common/title_logo.webp"
    }

    public fun nft_link_url() : vector<u8> {
        b"https://www.bravefrontierversus.com/ja"
    }

    public fun royality_address() : address {
        @0xcd8339e292b0b67627e2223337ec2812f53f1562479a96e0f0c6ae244c055d4d
    }

    public fun token_oshi() : vector<u8> {
        b"0xf16656c7d417654680c9e6a67f626c2c99a7a91011c88bc50d9ccaffdc53081b::oshi::OSHI"
    }

    public fun token_oshisui() : vector<u8> {
        b"0x95f9ff87d8e0640cb3369bb470761b9ec46eb0ff3cc1eed417df4fa24c853f42::oshi_sui::OSHI_SUI"
    }

    public fun token_sui() : vector<u8> {
        b"0x2::sui::SUI"
    }

    public fun token_usdc() : vector<u8> {
        b"0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC"
    }

    public fun withdraw_min_amount() : u64 {
        0
    }

    // decompiled from Move bytecode v6
}

