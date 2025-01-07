module 0x3eefa15343dc3c1823eb228b1cb10461768023e9b6ac4a58b92ef1e9ac0f2806::sumer {
    struct SUMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMER>(arg0, 6, b"SUMER", b"Sui Meme Party", x"57656c636f6d6520746f207468652062657374206d656d652070617274792073696e636520746865206c617374206d656d65636f696e20736561736f6e2c206f6e6c79206f6e20746865200a405375694e6574776f726b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/smp_7a24e2f2a6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUMER>>(v1);
    }

    // decompiled from Move bytecode v6
}

