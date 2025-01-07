module 0x3a974933b3cb8e44d53af5a82d0827dbff48cd27262dbe9de9c9f15ace3a776::sbl {
    struct SBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBL>(arg0, 6, b"SBL", b"Sui Bull", x"2442756c6c27697368206f6e20746865200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bul_5a554f9b4a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

