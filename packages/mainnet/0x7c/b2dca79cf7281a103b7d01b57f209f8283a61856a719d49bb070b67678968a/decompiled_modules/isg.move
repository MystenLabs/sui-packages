module 0x7cb2dca79cf7281a103b7d01b57f209f8283a61856a719d49bb070b67678968a::isg {
    struct ISG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISG>(arg0, 6, b"ISG", b"Infinite Sui Glitch", b"This coin is designed to be a hedge for all markets. This is the infinite sui glitch. Bear or Bull this is the only investment that will never be rugged.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1740786398411.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ISG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

