module 0xc1a2385d16b07426090b31a851d5246d42563d238cb72de1f2e7410ad8e1cc63::bldy {
    struct BLDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLDY>(arg0, 6, b"BLDY", b"Baldy", x"42616c6420646576206f6e207375692070756d702066616365200a4f6e626f61726420746865206d617373657320", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/giphy_11af9df048.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

