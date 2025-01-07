module 0x2e0c0385274d1e518b15a5648629f355e59ec6360125a5739d8b401be6378269::ssl {
    struct SSL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSL>(arg0, 6, b"SSL", b"Spinning Sea Lion", b"Sea Lion spinning on SUI waves", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/otter_spin_eefe557275.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSL>>(v1);
    }

    // decompiled from Move bytecode v6
}

