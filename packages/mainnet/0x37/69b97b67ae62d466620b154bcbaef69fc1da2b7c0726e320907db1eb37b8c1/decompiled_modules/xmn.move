module 0x3769b97b67ae62d466620b154bcbaef69fc1da2b7c0726e320907db1eb37b8c1::xmn {
    struct XMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: XMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3769b97b67ae62d466620b154bcbaef69fc1da2b7c0726e320907db1eb37b8c1::upgrade_service::new<XMN>(arg0, 0x2::tx_context::sender(arg1), arg1);
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<XMN>(v1, 6, b"XXC", b"XXC", b"<placeholder>", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"<placeholder>"))), true, arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XMN>>(v4);
        0x2::transfer::public_share_object<0x3769b97b67ae62d466620b154bcbaef69fc1da2b7c0726e320907db1eb37b8c1::treasury::Treasury<XMN>>(0x3769b97b67ae62d466620b154bcbaef69fc1da2b7c0726e320907db1eb37b8c1::treasury::new<XMN>(v2, v3, 0x2::tx_context::sender(arg1), 0x2::tx_context::sender(arg1), 0x2::tx_context::sender(arg1), 0x2::tx_context::sender(arg1), 0x2::tx_context::sender(arg1), arg1));
        0x2::transfer::public_share_object<0x3769b97b67ae62d466620b154bcbaef69fc1da2b7c0726e320907db1eb37b8c1::upgrade_service::UpgradeService<XMN>>(v0);
    }

    // decompiled from Move bytecode v6
}

