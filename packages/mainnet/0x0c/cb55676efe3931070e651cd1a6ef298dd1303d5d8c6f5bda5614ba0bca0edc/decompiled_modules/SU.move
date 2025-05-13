module 0xccb55676efe3931070e651cd1a6ef298dd1303d5d8c6f5bda5614ba0bca0edc::SU {
    struct SU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SU>(arg0, 6, b"SU", b"mi pan su su su ", x"4d692070616e2073752073752073756d207375207375207375206d692070616e2079616b616b75737520c3b1616d20c3b1616d20c3b1616d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/Qmf1pAoSYiA5UqcMfcWf16WeHH88n2DjxpdyuoSHrFjsRH")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

