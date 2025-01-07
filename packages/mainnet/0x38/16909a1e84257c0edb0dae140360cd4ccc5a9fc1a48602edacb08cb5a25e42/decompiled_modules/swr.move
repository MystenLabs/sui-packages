module 0x3816909a1e84257c0edb0dae140360cd4ccc5a9fc1a48602edacb08cb5a25e42::swr {
    struct SWR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWR>(arg0, 6, b"SWR", b"SuiWate", x"23537569732062656c6f766564206d6173636f7420746f6b656e21204469766520696e746f207468652072656672657368696e6720776f726c64206f66202457415445522c207768657265206761696e7320666c6f7773210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/water_dd93c3ff88.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWR>>(v1);
    }

    // decompiled from Move bytecode v6
}

