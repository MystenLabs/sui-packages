module 0x93e06a04cd6e09aa652dfc81fc7d4233f703f70f95536c0c239d03962b047794::suibob {
    struct SUIBOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBOB>(arg0, 6, b"SUIBOB", b"SUIBOB WETPANTS", b"He lives in a coconut under a tree! SUI-BOB WET-PANTS!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2025_05_06_145658_490c01331b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

