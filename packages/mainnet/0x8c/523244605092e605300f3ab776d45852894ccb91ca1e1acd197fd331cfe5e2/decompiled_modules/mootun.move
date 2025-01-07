module 0x8c523244605092e605300f3ab776d45852894ccb91ca1e1acd197fd331cfe5e2::mootun {
    struct MOOTUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOTUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOTUN>(arg0, 6, b"MOOTUN", b"Moo Tun", b"MOO TUN IS THE BROTHER OF MOO DENG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d_X1kh0ix_400x400_e567fbe532.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOTUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOOTUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

