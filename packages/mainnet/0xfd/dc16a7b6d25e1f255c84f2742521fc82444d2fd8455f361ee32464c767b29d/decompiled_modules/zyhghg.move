module 0xfddc16a7b6d25e1f255c84f2742521fc82444d2fd8455f361ee32464c767b29d::zyhghg {
    struct ZYHGHG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZYHGHG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZYHGHG>(arg0, 9, b"ZYHGHG", b"gghfhgfgf", b"hghghgh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/db240012-749a-471b-b943-1a608cafe5b2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZYHGHG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZYHGHG>>(v1);
    }

    // decompiled from Move bytecode v6
}

