module 0x4891bd53882718eabcd419954480ddea49c650a35340de9ecc957fc84d6cefed::imp {
    struct IMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: IMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IMP>(arg0, 9, b"IMP", b"Imp", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3Bvr8k1XRFG1aHznJ3N8L-97c4Xf8-h9Ecg&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IMP>(&mut v2, 3333333333000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IMP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

