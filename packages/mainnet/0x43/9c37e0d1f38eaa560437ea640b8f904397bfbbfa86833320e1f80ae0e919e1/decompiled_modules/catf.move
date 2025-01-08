module 0x439c37e0d1f38eaa560437ea640b8f904397bfbbfa86833320e1f80ae0e919e1::catf {
    struct CATF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATF>(arg0, 6, b"CATF", b"CATF", b"The Blinking AI Cat - Catfather", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.okx.com/cdn/web3/currency/token/501-7uCHQdxAz2ojRgEpXRHas1nJAeTTo9b7JWNgpXXi9D9p-98.png/type=default_350_0?v=1735918971738&x-oss-process=image/format,webp/ignore-error,1"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATF>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CATF>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATF>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

