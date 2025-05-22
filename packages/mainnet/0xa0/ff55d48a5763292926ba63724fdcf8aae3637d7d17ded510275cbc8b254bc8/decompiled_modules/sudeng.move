module 0xa0ff55d48a5763292926ba63724fdcf8aae3637d7d17ded510275cbc8b254bc8::sudeng {
    struct SUDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUDENG>(arg0, 9, b"sudeng", b"HIPPO", b"SuDeng is the cutest $HIPPO on SUI, bringing $HIPPO to the world of memes. No cats, no dogs. Only $HIPPO.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://strapi-dev.scand.app/uploads/Su_Deng_logo_139eb7755c.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUDENG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUDENG>>(0x2::coin::mint<SUDENG>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUDENG>>(v2);
    }

    // decompiled from Move bytecode v6
}

