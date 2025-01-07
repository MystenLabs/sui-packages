module 0xbedecaba8db42b8f3745cf2ee1fef1ee96601b74fc0a58ffd460300e15195f::sticky {
    struct STICKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: STICKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STICKY>(arg0, 6, b"STICKY", b"SUI STICKY", b"cikikikiki", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sticky_40eaefa84f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STICKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STICKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

