module 0x1c688d3266733591514ab0f78fb58e9e5870f4ed190420a74e0cf1b10afca901::mps {
    struct MPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MPS>(arg0, 6, b"MPS", b"Meme Party SUI", x"405375694d656d6550617274790a57656c636f6d6520746f207468652062657374206d656d652070617274792073696e636520746865206c617374206d656d65636f696e20736561736f6e2c206f6e6c79206f6e20746865200a405375694e6574776f726b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/smp_a577d6d0d4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

