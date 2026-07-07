module 0xfd28992da9a0452bd8c7971ea830ee3a944310e1be13a280a77fe1cb8e74d3b5::myt_token {
    struct MYT_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYT_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MYT_TOKEN>(arg0, 6, b"MYT", b"Myt Token Name", b"Myt Token Description", 0x1::option::none<0x2::url::Url>(), true, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYT_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MYT_TOKEN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYT_TOKEN>>(v2);
    }

    // decompiled from Move bytecode v6
}

