module 0xadde39bc97d4c0f8571434686d5d73f7d923fcfda0ef7db2d8c5597cf0f6bdac::mira {
    struct MIRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIRA>(arg0, 9, b"MIRA", b"MIRA", b"MIRA pair launch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://is1-ssl.mzstatic.com/image/thumb/Features125/v4/5d/83/50/5d835053-54f8-a7ae-6585-80ae84ea4c2a/pr_source.png/400x400bb.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MIRA>(&mut v2, 600000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIRA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

