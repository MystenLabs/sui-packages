module 0x997f612a01aefcaa56137231413793ad5080502f8e46fd48c9f4a340152218e4::xsui {
    struct XSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: XSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XSUI>(arg0, 9, b"xSUI", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XSUI>>(v1);
        0x2::transfer::public_transfer<0x997f612a01aefcaa56137231413793ad5080502f8e46fd48c9f4a340152218e4::pool::AdminCap<0x2::sui::SUI>>(0x997f612a01aefcaa56137231413793ad5080502f8e46fd48c9f4a340152218e4::pool::create<0x2::sui::SUI, XSUI>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

