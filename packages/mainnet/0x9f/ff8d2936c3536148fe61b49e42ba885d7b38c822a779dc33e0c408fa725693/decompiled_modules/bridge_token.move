module 0x9fff8d2936c3536148fe61b49e42ba885d7b38c822a779dc33e0c408fa725693::bridge_token {
    struct BRIDGE_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRIDGE_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9fff8d2936c3536148fe61b49e42ba885d7b38c822a779dc33e0c408fa725693::upgrade_service_token::new<BRIDGE_TOKEN>(arg0, 0x2::tx_context::sender(arg1), arg1);
        let (v2, v3) = 0x2::coin::create_currency<BRIDGE_TOKEN>(v1, 6, b"LKXMN", b"LKXMN", b"Locked representation of 0x97c7571f4406cdd7a95f3027075ab80d3e9c937c2a567690d31e14ab1872ccee::xmn::XMN", 0x1::option::none<0x2::url::Url>(), arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRIDGE_TOKEN>>(v3);
        let (v5, v6) = 0x2::token::new_policy<BRIDGE_TOKEN>(&v4, arg1);
        0x2::token::share_policy<BRIDGE_TOKEN>(v5);
        0x2::transfer::public_share_object<0x9fff8d2936c3536148fe61b49e42ba885d7b38c822a779dc33e0c408fa725693::treasury::Treasury<BRIDGE_TOKEN>>(0x9fff8d2936c3536148fe61b49e42ba885d7b38c822a779dc33e0c408fa725693::treasury::new<BRIDGE_TOKEN>(v4, v6, 0x2::tx_context::sender(arg1), arg1));
        0x2::transfer::public_share_object<0x9fff8d2936c3536148fe61b49e42ba885d7b38c822a779dc33e0c408fa725693::upgrade_service_token::UpgradeService<BRIDGE_TOKEN>>(v0);
    }

    // decompiled from Move bytecode v6
}

