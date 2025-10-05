module 0xe52acc0ade468a76d7473f731b0c9feca26f6c178e726ad989f314f554db22b6::xmn {
    struct XMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: XMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XMN>(arg0, 9, b"XMN", b"xMoney", b"Your unified gateway to the future of payments. Crypto-enabled & Fiat-ready.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://strapi-dev.scand.app/uploads/XMN_logo_ea721dd614.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XMN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<XMN>>(0x2::coin::mint<XMN>(&mut v2, 10000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<XMN>>(v2);
    }

    // decompiled from Move bytecode v6
}

