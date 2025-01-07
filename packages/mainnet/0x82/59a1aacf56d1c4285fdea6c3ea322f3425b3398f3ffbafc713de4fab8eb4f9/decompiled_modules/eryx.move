module 0x8259a1aacf56d1c4285fdea6c3ea322f3425b3398f3ffbafc713de4fab8eb4f9::eryx {
    struct ERYX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERYX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERYX>(arg0, 6, b"ERYX", b"Eryx Engineer", b"Revered as the god-creator of tokens in the $SUI blockchain and an NFT visionary, Eryx is a master of blockchain technology and the creator of trends that redefine digital culture.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734863118395.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ERYX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERYX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

