module 0x28749497857433067f7d738b9751ebae70df045af705d2587023fe17968f3854::chan {
    struct CHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAN>(arg0, 6, b"CHAN", b"Suinchan", b"Suin-chan is an innovative project built on the SUI chain that combine The name Shinchan creatively merges SUI and Shin-chan, drawing inspiration from the beloved character Shin-chan.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suincan_Logo_4895d56803.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

