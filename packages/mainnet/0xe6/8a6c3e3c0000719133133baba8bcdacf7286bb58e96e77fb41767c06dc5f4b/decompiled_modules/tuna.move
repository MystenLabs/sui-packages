module 0xe68a6c3e3c0000719133133baba8bcdacf7286bb58e96e77fb41767c06dc5f4b::tuna {
    struct TUNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUNA>(arg0, 6, b"TUNA", b"Oh My Tuna", b"Make by Tuna lover on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747983811835.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUNA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUNA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

