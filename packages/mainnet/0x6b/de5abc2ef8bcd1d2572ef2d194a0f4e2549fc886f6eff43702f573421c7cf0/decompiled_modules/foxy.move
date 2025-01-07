module 0x6bde5abc2ef8bcd1d2572ef2d194a0f4e2549fc886f6eff43702f573421c7cf0::foxy {
    struct FOXY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOXY>(arg0, 6, b"FOXY", b"FoxWifHat", b"Foxy finally on SUI. His entrance move: https://x.com/foxwifhatonsol/status/1842308133470851174", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/foxy_nose_0792af0ffd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOXY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOXY>>(v1);
    }

    // decompiled from Move bytecode v6
}

