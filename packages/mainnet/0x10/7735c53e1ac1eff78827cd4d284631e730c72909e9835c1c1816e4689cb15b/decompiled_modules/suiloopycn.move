module 0x107735c53e1ac1eff78827cd4d284631e730c72909e9835c1c1816e4689cb15b::suiloopycn {
    struct SUILOOPYCN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILOOPYCN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILOOPYCN>(arg0, 6, b"SUILOOPYCN", b"SUILOOPY", x"546865206d6f73742061646f7261626c652063756c7420746f206576657220696e76616465205355490a0a20202020202021200a0a2021200a0a2020202c202021200a0a547769747465723a2068747470733a2f2f782e636f6d2f4c6f6f70795355490a576562736974653a2068747470733a2f2f6c6f6f70792e6c6f76652f0a4c496e6b747265653a2068747470733a2f2f6c696e6b74722e65652f6c6f6f7079737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3495_f0004adb6c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILOOPYCN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILOOPYCN>>(v1);
    }

    // decompiled from Move bytecode v6
}

