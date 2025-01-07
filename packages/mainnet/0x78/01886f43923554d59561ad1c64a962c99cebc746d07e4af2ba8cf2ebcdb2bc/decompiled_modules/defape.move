module 0x7801886f43923554d59561ad1c64a962c99cebc746d07e4af2ba8cf2ebcdb2bc::defape {
    struct DEFAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEFAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEFAPE>(arg0, 6, b"DEFAPE", b"Def Apes", b"We all have those people in our lives that have told us that crypto was not going anywhere and we were wasting our time. We have always been DEF to that noise! And we all get convicted on our tokens we love and APE hard into them. We are all DEF APES.. DEF to the Noise and APES till we die! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048538_ec2d7d2b67.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEFAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEFAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

