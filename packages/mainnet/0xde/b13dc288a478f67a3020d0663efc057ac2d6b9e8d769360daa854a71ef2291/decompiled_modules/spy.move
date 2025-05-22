module 0xdeb13dc288a478f67a3020d0663efc057ac2d6b9e8d769360daa854a71ef2291::spy {
    struct SPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPY>(arg0, 6, b"SPY", b"SuiPay", b"SuiPay is designed to be the backbone of payments and liquidity on Sui, offering a fixed supply model that balances sustainability and utility.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigfttp7gcldom4wjnym3xusgygijy4te62inya4keitcnbsns4xhu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

