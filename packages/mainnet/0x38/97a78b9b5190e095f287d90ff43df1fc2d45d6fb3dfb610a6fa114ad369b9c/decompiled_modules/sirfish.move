module 0x3897a78b9b5190e095f287d90ff43df1fc2d45d6fb3dfb610a6fa114ad369b9c::sirfish {
    struct SIRFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIRFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIRFISH>(arg0, 6, b"SIRFISH", b"Sir Fish", x"536972204669736820697320676f6f6420617420736176696e672070656f706c652066726f6d2064656570207472656e6368657320776974682068697320666c61776c6573732074726164696e67207374796c652e0a0a42757420646f6e2774206265206d697374616b656e2e204865206973206a757374206120627573696e6573736d616e20776974682061206669736820686561642e2048652063616e2774207377696d2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6078126473807512617_1_d78480f2a0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIRFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIRFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

