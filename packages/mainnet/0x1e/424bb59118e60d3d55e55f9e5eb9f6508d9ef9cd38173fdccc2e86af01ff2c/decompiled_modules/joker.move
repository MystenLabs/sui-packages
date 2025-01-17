module 0x1e424bb59118e60d3d55e55f9e5eb9f6508d9ef9cd38173fdccc2e86af01ff2c::joker {
    struct JOKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOKER>(arg0, 6, b"JOKER", b"SUI JOKER AI", b"Welcome to my Sui-side show! I've taken over the Sui network, and now every transaction's a surprise! Watch your $JOKER multiply or vanish - it's all part of the thrill! Embrace the madness, the Sui network is my playground now. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737140316384.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOKER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOKER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

