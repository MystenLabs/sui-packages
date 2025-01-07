module 0x47e6122e04ab90d49fec8abc1bcef8154fb94bb4bd21e911e5cb52f7b48af7bf::quack {
    struct QUACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUACK>(arg0, 6, b"QUACK", b"Ugly Duck", b"QUACK!QUACK!QUACK! Enjoy our Quack game on the website!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ppp_8a3def6e4e.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

