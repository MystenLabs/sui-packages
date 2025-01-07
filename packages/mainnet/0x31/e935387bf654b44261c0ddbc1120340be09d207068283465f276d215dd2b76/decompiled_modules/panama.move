module 0x31e935387bf654b44261c0ddbc1120340be09d207068283465f276d215dd2b76::panama {
    struct PANAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANAMA>(arg0, 6, b"PANAMA", b"Panama", x"50414e414d4120547269616c2023340a54686973206973206120747269616c206f66207468652050414e414d4120746f6b656e20616e642077686974656c697374696e672e0a48657265206973207468652072657374206f6620746865207465787420726571756972656420746f2074616b652075702074686520506f6f6c204465736320746f203132382063686172732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1721047634576_66618f9ceee542ef6955e8da34e496bb_076861daae.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PANAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

