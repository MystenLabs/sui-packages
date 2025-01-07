module 0x2ee780697a7b80d789ee04f75098003540752c1ee93ef506037824ffdc21ca86::soap {
    struct SOAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOAP>(arg0, 6, b"SOAP", b"Dont Drop The Soap", b"[ Telegram : https://t.me/SoapOnSui ] [ Twitter : https://x.com/SoapOnSui ] [ Website : https://soap-sui.fun ]", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ppp_04f1855eef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

