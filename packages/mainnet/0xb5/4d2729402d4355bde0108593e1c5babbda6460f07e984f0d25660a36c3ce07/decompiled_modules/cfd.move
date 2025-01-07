module 0xb54d2729402d4355bde0108593e1c5babbda6460f07e984f0d25660a36c3ce07::cfd {
    struct CFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CFD>(arg0, 6, b"CFD", b"Cocaine fueled decisions", b"Im like super ready to be a millioner when eLoN tweets about elonwifcum! Like I just dumped all my cA$h into it, right? And wen he shouwts it outtt, am gonna be like, who needs a fucking job?! ill be sitting on a throne made of gold, eating pizza with unicorns!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048387_66e88f53ba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CFD>>(v1);
    }

    // decompiled from Move bytecode v6
}

