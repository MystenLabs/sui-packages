module 0xc09b82c9a7c8d16ea0bdeee12278cbb3312cbe1af59d869bc452cbb592f295c5::pleb {
    struct PLEB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLEB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLEB>(arg0, 6, b"PLEB", b"Pleb On Sui", x"54484520504c4542205245424f524e204f4e205355490a49532041204445434c41524154494f4e204f46204f555220554e4459494e4720535049524954205945542c204f5552204f44595353455920444f45534e275420454e4420484552452e200a54484520504c454220414c4c49414e4345204841532053504f4b454e3a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2acf6ce72fc8448fe9a526caa1042787_15f6cfa683.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLEB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLEB>>(v1);
    }

    // decompiled from Move bytecode v6
}

