module 0xa75bed9f4a41f506630c2f3cea5be7712277c0de4458fb2f7443b4af7d036e13::protoken {
    struct PROTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PROTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROTOKEN>(arg0, 9, b"PRO", b"ProToken", b"Protokendao", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775670408742-bd63381a777ca9476f5393d966aead13.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<PROTOKEN>>(0x2::coin::mint<PROTOKEN>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PROTOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PROTOKEN>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

