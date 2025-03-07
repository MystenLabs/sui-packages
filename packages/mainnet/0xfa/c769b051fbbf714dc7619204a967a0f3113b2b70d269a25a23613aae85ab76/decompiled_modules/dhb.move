module 0xfac769b051fbbf714dc7619204a967a0f3113b2b70d269a25a23613aae85ab76::dhb {
    struct DHB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DHB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DHB>(arg0, 6, b"DHB", b"Don't be a donkey!   HODL BITCOIN", b" Embrace the strategic approach of HODLing Bitcoin as a cornerstone of your investment philosophy. In an inherently volatile market, exercising patience is not merely advisable; it is essential for achieving long-term success. Cultivate a deep trust in the transformative potential of cryptocurrency, and maintain your investment with unwavering resolve. Your steadfast commitment to HODLing will ultimately yield substantial rewards as Bitcoin's value appreciates over time. Stay informed about market trends and developments, and remain focused on your investment goals; this disciplined approach is what distinguishes successful investors from their counterparts. By adopting this strategy, you are taking proactive steps to secure your financial future in the evolving landscape of digital assets.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/donkey_hodl_bitcoin_39c05b46db.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DHB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DHB>>(v1);
    }

    // decompiled from Move bytecode v6
}

