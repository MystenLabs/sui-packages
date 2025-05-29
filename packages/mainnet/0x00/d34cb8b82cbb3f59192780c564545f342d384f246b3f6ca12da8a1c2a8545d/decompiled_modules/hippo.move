module 0xd34cb8b82cbb3f59192780c564545f342d384f246b3f6ca12da8a1c2a8545d::hippo {
    struct HIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPO>(arg0, 9, b"sudeng", b"HIPPO", b"SuDeng is the cutest $HIPPO on SUI, bringing $HIPPO to the world of memes. No cats, no dogs. Only $HIPPO.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://strapi-dev.scand.app/uploads/Su_Deng_logo_139eb7755c.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIPPO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<HIPPO>>(0x2::coin::mint<HIPPO>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HIPPO>>(v2);
    }

    // decompiled from Move bytecode v6
}

