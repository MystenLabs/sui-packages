module 0x719205474cb35205a39cbc1ca7b905e4306072e996dae47ff4e72c7ddc0eb800::slt {
    struct SLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLT>(arg0, 8, b"SLT", b"Sui Lucky Slots", b"Casino game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/J1kQ60u.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SLT>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

