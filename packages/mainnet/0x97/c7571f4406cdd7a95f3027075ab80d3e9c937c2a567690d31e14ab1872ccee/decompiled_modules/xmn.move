module 0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn {
    struct XMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: XMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::upgrade_service::new<XMN>(arg0, 0x2::tx_context::sender(arg1), arg1);
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<XMN>(v1, 6, b"XMN", b"XMN", b"<placeholder>", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"<placeholder>"))), true, arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XMN>>(v4);
        0x2::transfer::public_share_object<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::treasury::Treasury<XMN>>(0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::treasury::new<XMN>(v2, v3, 0x2::tx_context::sender(arg1), 0x2::tx_context::sender(arg1), 0x2::tx_context::sender(arg1), 0x2::tx_context::sender(arg1), 0x2::tx_context::sender(arg1), arg1));
        0x2::transfer::public_share_object<0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::upgrade_service::UpgradeService<XMN>>(v0);
    }

    // decompiled from Move bytecode v6
}

