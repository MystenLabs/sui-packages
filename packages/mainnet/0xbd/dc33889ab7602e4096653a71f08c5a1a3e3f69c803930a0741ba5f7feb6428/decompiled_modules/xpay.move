module 0xbddc33889ab7602e4096653a71f08c5a1a3e3f69c803930a0741ba5f7feb6428::xpay {
    struct XPAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: XPAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XPAY>(arg0, 9, b"XPAY", b"XPAY", b"XPAY | X Competitor to Banks Elon Musk says X payments will eliminate the need for a bank account by the end of 2024. A new trademark called 'XPAY' Just being registered and will roll out soon to the public. An $XPAY meme token is being created, potentially front-running news from Elon Musk and X, and it could be the next big thing that Elon Musk has inspired", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0xd160fdad4b3cf8ff6ec5e1ec3343c6d21df19bc0.png?size=lg&key=b510df")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<XPAY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XPAY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XPAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

