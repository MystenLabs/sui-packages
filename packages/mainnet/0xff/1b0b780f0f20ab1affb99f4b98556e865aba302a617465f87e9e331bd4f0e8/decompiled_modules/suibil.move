module 0xff1b0b780f0f20ab1affb99f4b98556e865aba302a617465f87e9e331bd4f0e8::suibil {
    struct SUIBIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBIL>(arg0, 6, b"SUIBIL", b"SUI SYBIL", b"Are you suibil or not suibil?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suibil_fc6df1dc00.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

