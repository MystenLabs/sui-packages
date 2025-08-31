module 0x7059f17426539dcc0c564fccaabe6d516c895f8cd7ffc4340320b0f1f080f30f::doby {
    struct DOBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOBY>(arg0, 9, b"DOBY", b"SUI QUEEN", b"FT  5E 6H 6 RTY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOBY>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOBY>>(v2, @0x58c3d33642bef8d9ea56357f612052df947feb6de39cc9cf1baff20bc1b075d);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

