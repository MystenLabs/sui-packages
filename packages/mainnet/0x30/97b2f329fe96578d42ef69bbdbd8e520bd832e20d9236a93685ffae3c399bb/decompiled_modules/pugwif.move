module 0x3097b2f329fe96578d42ef69bbdbd8e520bd832e20d9236a93685ffae3c399bb::pugwif {
    struct PUGWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUGWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGWIF>(arg0, 6, b"PUGWIF", b"Pugwif", b"Pugwif Suins PFP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9680_461130db19.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUGWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

