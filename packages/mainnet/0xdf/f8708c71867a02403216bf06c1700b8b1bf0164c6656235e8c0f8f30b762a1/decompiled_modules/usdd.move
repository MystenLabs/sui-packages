module 0xdff8708c71867a02403216bf06c1700b8b1bf0164c6656235e8c0f8f30b762a1::usdd {
    struct USDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDD>(arg0, 6, b"USDD", b"Decentralized USD", b"The USDD protocol aims to provide the blockchain industry with the most stable, decentralized, tamper-proof, and freeze-free stablecoin system, a perpetual system independent from any centralized entity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735267370105.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

