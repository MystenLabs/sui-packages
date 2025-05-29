module 0xaedc7f5174e216feec0eb63fee9523a19a3dee5c70f59af3dad4269e3a01f3c6::sndeng {
    struct SNDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNDENG>(arg0, 9, b"HIPPO", b"sudeng", b"SuDeng is the cutest $HIPPO on SUI, bringing $HIPPO to the world of memes. No cats, no dogs. Only $HIPPO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://strapi-dev.scand.app/uploads/Su_Deng_logo_139eb7755c.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNDENG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SNDENG>>(0x2::coin::mint<SNDENG>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SNDENG>>(v2);
    }

    // decompiled from Move bytecode v6
}

