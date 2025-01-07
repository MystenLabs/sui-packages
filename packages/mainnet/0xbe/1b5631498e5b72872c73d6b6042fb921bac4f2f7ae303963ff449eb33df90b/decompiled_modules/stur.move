module 0xbe1b5631498e5b72872c73d6b6042fb921bac4f2f7ae303963ff449eb33df90b::stur {
    struct STUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: STUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STUR>(arg0, 9, b"STUR", b"SturgeonCoin", b"TO THE MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkGDQnodLVMq_Z7_LnozI58aLVBrObu_gRCOCDtERhZXyNJt2RZ_w1WnKGNHXne2VPANA&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STUR>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STUR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

