module 0x158d3cb869850f314b59240e0ab65f0339d7203b8933803e2de71b55f62cd683::laser {
    struct LASER has drop {
        dummy_field: bool,
    }

    fun init(arg0: LASER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LASER>(arg0, 6, b"LASER", b"Laser Eyes on Sui", b"Laser eyes project is next 1000x gem. Are you ready for bull season with laser eyes?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241109_185707_744cec92f4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LASER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LASER>>(v1);
    }

    // decompiled from Move bytecode v6
}

