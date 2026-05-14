module 0xbc9115ee32582a4736e9377dfe546337ea7347d825f42414c9fd25b11e3a24a4::usdc_flp_1 {
    struct USDC_FLP_1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDC_FLP_1, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<USDC_FLP_1>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::display::Display<0xbc9115ee32582a4736e9377dfe546337ea7347d825f42414c9fd25b11e3a24a4::flp::Flp1<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>>(0xbc9115ee32582a4736e9377dfe546337ea7347d825f42414c9fd25b11e3a24a4::flp::new_display<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v0, 0x1::string::utf8(b"USDC FLP-1 #{number}"), 0x1::string::utf8(b"Proof of participation in Current FLP-1, granting access to exclusive rewards for founding USDC liquidity partners on Sui."), 0x1::string::utf8(b"https://metadata.current.finance/flp-1-usdc.png"), arg1), 0x2::tx_context::sender(arg1));
        let (v1, v2) = 0xbc9115ee32582a4736e9377dfe546337ea7347d825f42414c9fd25b11e3a24a4::flp::new_policy<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0xbc9115ee32582a4736e9377dfe546337ea7347d825f42414c9fd25b11e3a24a4::flp::Flp1<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>>(v1);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0xbc9115ee32582a4736e9377dfe546337ea7347d825f42414c9fd25b11e3a24a4::flp::Flp1<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_usdc(arg0: &0xbc9115ee32582a4736e9377dfe546337ea7347d825f42414c9fd25b11e3a24a4::flp::MintCap, arg1: &mut 0xbc9115ee32582a4736e9377dfe546337ea7347d825f42414c9fd25b11e3a24a4::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0xbc9115ee32582a4736e9377dfe546337ea7347d825f42414c9fd25b11e3a24a4::flp::Flp1<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        0xbc9115ee32582a4736e9377dfe546337ea7347d825f42414c9fd25b11e3a24a4::flp::mint<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

