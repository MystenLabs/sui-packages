module 0x508eea600558493ce45c277c7e0a15fd74834d1cc1d22cc0e01eec68e7ba13f1::brock {
    struct BROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROCK>(arg0, 9, b"BROCK", b"BlackRock", b"First memcoin frome BLACKROCK. BUY TODAY - SELL TOMORROW. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a020f690-ba08-4e49-a374-6b3c6cd3dba8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BROCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

