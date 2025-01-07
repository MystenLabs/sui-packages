module 0xb1102e6e37ef9d0cd5bb38e75a7fca3b0579bcfb17818d9851948cbd30149aa5::eryx {
    struct ERYX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERYX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERYX>(arg0, 6, b"ERYX", b"Eryx Engineer", b"Revered as the god-creator of tokens in the $SUI blockchain and an NFT visionary, Eryx is a master of blockchain technology and the creator of trends that redefine digital culture.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734864064828.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ERYX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERYX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

