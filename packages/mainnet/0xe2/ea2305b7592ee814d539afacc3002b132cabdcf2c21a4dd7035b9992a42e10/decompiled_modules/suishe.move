module 0xe2ea2305b7592ee814d539afacc3002b132cabdcf2c21a4dd7035b9992a42e10::suishe {
    struct SUISHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHE>(arg0, 6, b"SUISHE", b"Suishe", x"496e74726f647563696e67202a2a5375697368652a2a2020706172742073757368692c2070617274206875736b792c20616e642031303025206261726b696e67206d616421200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_4_713e402ff5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHE>>(v1);
    }

    // decompiled from Move bytecode v6
}

