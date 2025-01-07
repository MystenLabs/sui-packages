module 0x3cceb98f972c145a3a9966b5e193ba01eec106022f41edc56546d377e88b30da::spump {
    struct SPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPUMP>(arg0, 6, b"SPUMP", b"SuiPump", b"The Leading Meme Fair Launch Platform on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/w9_N2_FJYF_400x400_c1147556cf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

