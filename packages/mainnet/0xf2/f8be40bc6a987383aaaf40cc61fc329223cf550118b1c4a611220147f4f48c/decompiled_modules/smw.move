module 0xf2f8be40bc6a987383aaaf40cc61fc329223cf550118b1c4a611220147f4f48c::smw {
    struct SMW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMW>(arg0, 6, b"SMW", b"Sui Meoww", b"Meoww Meoww Meoww Meoww Meoww Meoww Meoww Meoww Meoww", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MEOW_57af635e84.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMW>>(v1);
    }

    // decompiled from Move bytecode v6
}

