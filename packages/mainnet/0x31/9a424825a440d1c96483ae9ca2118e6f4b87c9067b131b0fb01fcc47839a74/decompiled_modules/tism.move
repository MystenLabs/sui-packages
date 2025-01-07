module 0x319a424825a440d1c96483ae9ca2118e6f4b87c9067b131b0fb01fcc47839a74::tism {
    struct TISM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TISM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TISM>(arg0, 6, b"TISM", b"SUI TISM", b"don't need luck when you have $tism", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tism_866b58cba1.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TISM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TISM>>(v1);
    }

    // decompiled from Move bytecode v6
}

