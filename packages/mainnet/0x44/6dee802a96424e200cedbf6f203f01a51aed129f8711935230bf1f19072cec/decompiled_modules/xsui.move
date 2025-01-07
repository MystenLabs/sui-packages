module 0x446dee802a96424e200cedbf6f203f01a51aed129f8711935230bf1f19072cec::xsui {
    struct XSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: XSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XSUI>(arg0, 9, b"xSUI", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XSUI>>(v1);
        0x2::transfer::public_transfer<0x446dee802a96424e200cedbf6f203f01a51aed129f8711935230bf1f19072cec::pool::AdminCap<0x2::sui::SUI>>(0x446dee802a96424e200cedbf6f203f01a51aed129f8711935230bf1f19072cec::pool::create<0x2::sui::SUI, XSUI>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

