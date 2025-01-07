module 0x31b7a1099f082424d5b0559e9f75c3754c7f9b8a2f51ae1b1ef186ed9216de4c::monie {
    struct MONIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONIE>(arg0, 6, b"MONIE", b"MonieOnSui", b"A furry cat, the new face of global curency", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000802_ed20f23f3d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

