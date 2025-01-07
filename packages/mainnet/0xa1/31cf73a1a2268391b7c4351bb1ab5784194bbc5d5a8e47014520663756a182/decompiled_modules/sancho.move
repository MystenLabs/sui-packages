module 0xa131cf73a1a2268391b7c4351bb1ab5784194bbc5d5a8e47014520663756a182::sancho {
    struct SANCHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANCHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANCHO>(arg0, 6, b"Sancho", b"Don Quixote", x"446f6e20517569786f7465202d204c6574277320666967687420616761696e737420746865206269672063727970746f63757272656e636965732053616e63686f2e200a53616e63686f202020202020202020202d204c65742773206d616b6520686973746f727920746f6765746865722e2e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731613036194.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SANCHO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANCHO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

