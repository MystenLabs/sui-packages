module 0xa4e825dd94bd236e29f9a0cda6bd45ebe7246300f4825db5349a05d5cc114a87::dmnd {
    struct DMND has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMND>(arg0, 9, b"DMND", b"Diamond", b"One mission: become the most expensive diamond in the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/3bx2tXD.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DMND>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMND>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DMND>>(v1);
    }

    // decompiled from Move bytecode v6
}

