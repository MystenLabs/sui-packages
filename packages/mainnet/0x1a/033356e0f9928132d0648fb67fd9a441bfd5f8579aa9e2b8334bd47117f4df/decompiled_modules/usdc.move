module 0x1a033356e0f9928132d0648fb67fd9a441bfd5f8579aa9e2b8334bd47117f4df::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDC>(arg0, 6, b"USDC", b"Unicorn Squid Dust Cum", b"Unicorn Squid Dust Cum($USDC) dives into a high-stakes crypto universe where holders face thrilling challenges inspired by Squid Game, with the ultimate prize of exponential gains for the clever and daring.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3456345_aacc6c9209.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

