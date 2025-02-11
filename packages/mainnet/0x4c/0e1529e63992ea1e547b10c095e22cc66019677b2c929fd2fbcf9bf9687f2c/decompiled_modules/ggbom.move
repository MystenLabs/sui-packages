module 0x4c0e1529e63992ea1e547b10c095e22cc66019677b2c929fd2fbcf9bf9687f2c::ggbom {
    struct GGBOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGBOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGBOM>(arg0, 9, b"GGBOM", b"GGBOM", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imgs.qiubiaoqing.com/qiubiaoqing/imgs/6401f9b4aeb187HK.gif")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GGBOM>>(v1);
        0x2::coin::mint_and_transfer<GGBOM>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGBOM>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

