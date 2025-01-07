module 0x5579d857274bb30dc24e94c72fd7f4b5915e4257f7c282c8c9c63ffac0b0127d::dguaubg {
    struct DGUAUBG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGUAUBG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGUAUBG>(arg0, 9, b"DGUAUBG", b"Dragon3388", b"Gm good products jdgabgyx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/15a345c8-7b76-4fe7-bc67-0b5e9963cd8a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGUAUBG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGUAUBG>>(v1);
    }

    // decompiled from Move bytecode v6
}

