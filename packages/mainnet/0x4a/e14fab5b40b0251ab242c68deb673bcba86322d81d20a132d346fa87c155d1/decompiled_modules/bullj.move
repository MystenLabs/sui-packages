module 0x4ae14fab5b40b0251ab242c68deb673bcba86322d81d20a132d346fa87c155d1::bullj {
    struct BULLJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLJ>(arg0, 9, b"BULLJ", b"Bulljauwal", b"For upcoming bull run", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9f73dd67-8943-4308-82b9-ebe193635172.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULLJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

